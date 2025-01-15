---
title: Software Supply Chain Attacks in GenAI's Era
layout: page
newsletter: true
social-share: true
show-avatar: true
image: /img/2025/npm-dependency-confusion.png
---


> Software supply chain attacks have taken on a new dimension in the era of Generative AI. As developers increasingly rely on AI-powered coding assistants and automated dependency management, attackers are finding novel ways to exploit these tools and processes. One particularly dangerous technique that has gained prominence is "Dependency Confusion," which demonstrates how modern development automation can be turned against organizations.

## Understanding Dependency Confusion

In 2021,  there was a novel attack technique named "Dependency confusion" published by Alex Birsan in a [blog post on Medium](https://medium.com/@alex.birsan/dependency-confusion-4a5d60fec610). With the technique, Alex managed to breach over 35 major companies' internal systems, including Microsoft, Apple, PayPal, Shopify, Netflix, Yelp, Tesla, and Uber.

![Image by Checkmarx](/img/2025/npm-dependency-confusion.png)

Here's a brief overview of how it works:

1. `Identifying Internal Packages`: The attacker identifies internal packages used by a company but not available in public repositories.

2. `Creating Counterfeit Packages`: The attacker creates counterfeit packages with the same names as the internal packages.

3. `Publishing Packages`: These counterfeit packages are then published to public repositories like npm, PyPI, or RubyGems.

4. `Automatic Installation`: When the company's build system pulls dependencies, it prioritizes the public repository, automatically installing the counterfeit package instead of the internal one.

5. `Executing Malicious Code`: The counterfeit package contains malicious code that gets executed, allowing the attacker to exfiltrate data or perform other malicious activities.

This attack is particularly dangerous for Software Supply Chain because it doesn't require any action from the victim. the malicious package is automatically installed due to the way such package registries work. They always prioritize public registries before private ones. Yes, sadly `it's a feature, not a bug`.

According to [a report by Sonatype](https://www.csoonline.com/article/3560646/malicious-open-source-software-packages-have-exploded-in-2024.html), there has been a significant rise in malicious open-source software packages across various registries, including npm, PyPI, and RubyGems. Over 500,000 new malicious packages were tracked since November 2023, highlighting the growing threat to software supply chain.

## The AI factor

And now, with the rise of AI-powered coding assistants like e.g [Copilot](https://copilot.microsoft.com/),  [Cursor](https://www.cursor.com/), the attack surface for supply chain attacks has expanded even further. These tools provide code suggestions, auto-completion, and even generate entire functions based on the context. However, they also introduce new risks, especially when it comes to package dependencies. These tools integrate directly into the development environment, automatically pulling in suggested packages without requiring manual review. This automation can bypass traditional security checks that might catch a suspicious package name.

Recently, Paul McCarty, a Security Researcher, has published an article named [Snyk security researcher deploys malicious NPM packages targeting Cursor.com](https://sourcecodered.com/snyk-malicious-npm-package/). Long story short: A security researcher from Snyk deployed packages on NPM targeting Cursor. These packages, such as "cursor-retreival" and "cursor-shadow-workspace," were designed to gather user system data and send it to an attacker-controlled web service, potentially exposing sensitive information. OpenSSF identified these packages as malicious. It's suspected this was a dependency confusion attack, though the researcher's intentions remain unclear.

## Mitigation Strategies

It’s important to note that no single mitigation strategy is foolproof. To mitigate these risks, it's crucial for organizations to adopt a multi-layered approach that combines technical controls, process improvements, and employee awareness. Here are some best practices to consider:

- `Use Private Registries`: Keep internal packages in private registries and configure development environments to prioritize these over public ones. Internal packages should have unique & company-specific identifiers to avoid name conflicts with public packages.

- `Version locking`: Lock dependencies to specific versions to prevent automatic updates from pulling in malicious code. This can be done using `package-lock.json` (in npm) or `Gemfile.lock` (in Ruby).

- `Proactive Monitoring`: Regularly scan dependencies for vulnerabilities and monitor for suspicious activity. Tools like Snyk, WhiteSource, or Sonatype can help automate this process.

- `Awareness Training`: Last but not least, educate developers on the risks of supply chain attacks. Always review suggested code and dependencies before accepting them, and be aware of the potential security implications.

In conclusion, the rise of AI-powered coding assistants has brought new opportunities for developers to write code faster and more efficiently. However, it also introduces new risks in Software Supply Chain, especially when it comes to package dependencies. Be vigilant to protect your organization from these emerging threats.
