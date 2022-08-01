import torch

isCudaAvailable = torch.cuda.is_available()

print(f"Is cuda available: {isCudaAvailable}")
