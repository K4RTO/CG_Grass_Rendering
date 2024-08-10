#pragma once

#pragma comment(linker, "/subsystem:console")
#include <windows.h>


#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

struct GLFWwindow;
struct GLFWwindow* GetGLFWWindow();

void InitializeWindow(int width, int height, const char* name);
bool ShouldQuit();
void DestroyWindow();
