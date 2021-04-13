# CT4101 - ML Assignment 2
# Student Name(s): Tapan Auti, Atharva Kulkarni
# Student ID(s): 20231499, 20231773

import pandas as pd
import numpy as np

# 1 Author: Atharva
# Sigmoid Function Definition


def f(z):
    return 1 / (1 + np.exp(-z))


# 1 Author: Tapan
# Calculate loss function
def loss_gradient(w, x, b):
    z = np.dot(x, w)
    y = f(z)
    loss = (-b * np.log(y) - (1 - b) * np.log(1 - y)).mean()
    gdn = np.dot(x.T, (b - y)) / b.size

    # 1 Author: Atharva
    # Normalising Gradient Descent
    grad = gdn + 300 / (2 * b.size) * np.concatenate(([0], w[1:])).T
    return loss, grad


# 1 Author: Tapan
# Training Function
def model_fit(x, b, total_iterations=5000):
    final_w = []
    label = np.unique(b)
    all_loss = np.zeros(total_iterations)

    for c in label:
        b = np.where(b == c, 1, 0)
        w = np.zeros(x.shape[1])
        for i in range(total_iterations):
            all_loss[i], grad = loss_gradient(w, x, b)
            w += 0.01 * grad
        final_w.append(w)
    return final_w, label, all_loss


# 1 Author: Atharva
# Predict Function
def predict_prob(label, w, x):
    preds = [np.argmax([f(i@j) for j in final_w]) for i in x]
    return [label[p] for p in preds]


# 1 Author: Atharva
# Calculate Accuracb of the model
def accuracy(label, w, x, b):
    acc = predict_prob(label, w, x)
    return (acc == b).mean()


    # 2 Authors: Tapan, Atharva
# Pre processing data set beer.txt
df = pd.read_csv("moons400.csv")

# 2 Authors: Tapan, Atharva



data = np.array(df)

num_train = int(.70 * len(data))
num_test = int(0.15 * len(data))

x_train, y_train = data[:num_train, :-1], data[:num_train, -1]
x_test, y_test = data[num_test:, :-1], data[num_test:, -1]
final_w, label, losses = model_fit(x_train, y_train)
print(f"Test Accuracy  : {accuracy(label, final_w, x_test, y_test):.6f}")
print(final_w)
