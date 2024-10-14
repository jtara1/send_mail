from setuptools import setup, find_packages

setup(
    name="send-mail",
    version="1.0.2",
    description="simple command-line for sending an email with remote auth",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    author="James T",
    author_email="j@elk.gg",
    license="Apache 2.0",
    packages=find_packages(),
    python_requires=">=3.11",
    entry_points={
        "console_scripts": [
            "send-mail=send_mail:command_line",
        ],
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.11",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: OS Independent",
    ],
)
