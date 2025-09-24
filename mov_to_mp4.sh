#!/bin/bash

# 脚本：将指定文件夹下的所有 .mov 文件转换为 .mp4 格式
# 使用方法：./mov_to_mp4.sh [文件夹路径]
# 如果不提供文件夹路径，默认处理当前目录

# 设置目标文件夹
TARGET_DIR=${1:-.}

# 检查文件夹是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "错误：文件夹 '$TARGET_DIR' 不存在"
    exit 1
fi

# 检查是否安装了 ffmpeg
if ! command -v ffmpeg &> /dev/null; then
    echo "错误：未找到 ffmpeg，请先安装 ffmpeg"
    echo "安装方法："
    echo "  macOS: brew install ffmpeg"
    echo "  Ubuntu: sudo apt install ffmpeg"
    exit 1
fi

# 计数器
converted_count=0
total_count=0

echo "开始转换文件夹 '$TARGET_DIR' 中的 .mov 文件..."

# 查找所有 .mov 文件并计数
for file in "$TARGET_DIR"/*.mov "$TARGET_DIR"/*.MOV; do
    if [ -f "$file" ]; then
        ((total_count++))
    fi
done

if [ $total_count -eq 0 ]; then
    echo "在文件夹 '$TARGET_DIR' 中未找到 .mov 文件"
    exit 0
fi

echo "找到 $total_count 个 .mov 文件"

# 转换所有 .mov 文件
for file in "$TARGET_DIR"/*.mov "$TARGET_DIR"/*.MOV; do
    if [ -f "$file" ]; then
        # 获取文件名（不含扩展名）
        filename=$(basename "$file")
        name="${filename%.*}"
        
        # 输出文件路径
        output_file="$TARGET_DIR/${name}.mp4"
        
        echo "正在转换: $filename"
        
        # 使用 ffmpeg 转换，保持原始质量
        if ffmpeg -i "$file" -c:v libx264 -c:a aac -preset medium -crf 23 -y "$output_file" 2>/dev/null; then
            echo "✓ 转换成功: ${name}.mp4"
            ((converted_count++))
        else
            echo "✗ 转换失败: $filename"
        fi
    fi
done

echo ""
echo "转换完成！"
echo "成功转换: $converted_count/$total_count 个文件"

# 询问是否删除原始 .mov 文件
if [ $converted_count -gt 0 ]; then
    echo ""
    read -p "是否删除原始 .mov 文件？(y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        for file in "$TARGET_DIR"/*.mov "$TARGET_DIR"/*.MOV; do
            if [ -f "$file" ]; then
                rm "$file"
                echo "已删除: $(basename "$file")"
            fi
        done
    fi
fi
