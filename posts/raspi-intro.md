---
title:  Introduction to Raspberry Pi
description: This is my first post, it is an introduction to Raspberry Pi.
date: 2021-10-15
tags:
  - raspberry pi
layout: layouts/post.njk
---

# So you want to find out about the Raspberry Pi? 

I would be surprised if you've never heard of them, since they seem to have exploded in popularity in recent years. They are very popular with those who want to get into programming and electronics, or Linux in general.  

*Just a quick disclaimer, though I have been using Pis in some form for over 5 years now I can only really say I  have casual experience with Pis and as such what is written here may be subjective or incorrect in some ways. I suggest you do your own research if you want to get into them, or if you're someone with knowledge of them and want to correct me feel free to contact me.*  

## But first, just a little bit of history

The Raspberry Pi Foundation (RPF), based in the UK launched their first model of the Raspberry Pi in 2012, this was the Model B. The RPF has made one of the first affordable credit card sized computers. The Pis are designed to be intuitive (especially with Raspbian Desktop - its main OS) and suitable for educational purposes. They are still making models to this day, with the Raspberry Pi 400 being launched in November 2020 and the Pico (Microcontroller) being released in 2021.  

## So, why should you get a Pi?

It may seem like these single board computers are a bit underwhelming. What, the best model only has 8GB of RAM?! Well you see not everyone has the money to spend hundreds or even thousands of pounds on a computer. This leads me to what I think is the best thing about these: they're cheap. For example the Raspberry Pi Zero costs ~£5 and can do plenty of things that it's successors can. Sure it does it to a lesser extent but to me at least that is part of the fun, given what you've got how can I make *x* work?  
Another reason is that if you have an idea, you can probably make it with a Raspberry Pi. As you'll see in the resources section, there are so many different things you can do, and for a lot of them you don't really need to know that much beforehand, just get stuck in. Want to make a NAS, retro games player, host your own website, play around with some electronics? The Pi has you covered.  

## Series 
### Zero

The Raspberry Pi Zero (released in 2015) is a much smaller device - around half the size of the Raspberry Pi model A+. The original Zero had these specifications:
- 1GHz single-core CPU
- 512MB RAM
- Mini HDMI port
- Micro USB OTG port
- Micro USB power
- HAT-compatible 40-pin header
- Composite video and reset headers
- CSI camera connector  

Given its size and low specifications, it is highly portable and has very low power consumption. This also makes it suitable for use in embedded systems. For example it would work well in a drone with a camera attached to the Zero.

### Pico 

The Raspberry Pi Pico was released in 2021 with a price of ~£3 with these features:
- RP2040 microcontroller chip designed by Raspberry Pi in the United Kingdom
- Dual-core Arm Cortex M0+ processor, flexible clock running up to 133 MHz
- 264KB of SRAM, and 2MB of on-board Flash memory
- Castellated module allows soldering direct to carrier boards
- USB 1.1 with device and host support
- Low-power sleep and dormant modes
- Drag-and-drop programming using mass storage over USB
- 26 × multi-function GPIO pins
- 2 × SPI, 2 × I2C, 2 × UART, 3 × 12-bit ADC, 16 × controllable PWM channels
- Accurate clock and timer on-chip
- Temperature sensor
- Accelerated floating-point libraries on-chip
- 8 × Programmable I/O (PIO) state machines for custom peripheral support  

 Like the Zero, the Pico can also be used as part of an embedded system such as acting as a temperature sensor for someewhere like a greenhouse
 
### Other
A popular model of the Raspberry Pi is the Model 4B:
- Broadcom BCM2711, Quad core Cortex-A72 (ARM v8) 64-bit SoC @ 1.5GHz
- 2GB, 4GB or 8GB LPDDR4-3200 SDRAM (depending on model)
- 2.4 GHz and 5.0 GHz IEEE 802.11ac wireless, Bluetooth 5.0, BLE
- Gigabit Ethernet
- 2 USB 3.0 ports; 2 USB 2.0 ports.
- Raspberry Pi standard 40 pin GPIO header 
- 2 × micro-HDMI ports (up to 4kp60 supported)
- 2-lane MIPI DSI display port
- 2-lane MIPI CSI camera port
- 4-pole stereo audio and composite video port
- H.265 (4kp60 decode), H264 (1080p60 decode, 1080p30 encode)
- OpenGL ES 3.1, Vulkan 1.0
- Micro-SD card slot for loading operating system and data storage
-5V DC via USB-C connector (minimum 3A)
- 5V DC via GPIO header (minimum 3A*)
- Power over Ethernet (PoE) enabled (requires separate PoE HAT)  

The Pi Model 4B can be powerful enough to run some quite intensive things, given the right environment. For example (though not with a 4B) I used to run Retropie for running some retro games with decent performance.

## Links to some resources

1. [Raspberry Pi Official site](https://www.raspberrypi.org/)
2. [Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/)
3. [Raspberry Pi Forums](https://www.raspberrypi.org/forums/)
4. [Raspberry Pi YouTube Channel](https://www.youtube.com/c/raspberrypi)
5. [Sample Raspberry Pi Projects](https://projects.raspberrypi.org/en)
6. [Raspberry Pi StackExchange](https://raspberrypi.stackexchange.com/)
7. [Opensource.com Pi](https://opensource.com/tags/raspberry-pi)
8. [Instructables Pi](https://www.instructables.com/circuits/raspberry-pi/projects/)
9. [Hackaday Pi](https://hackaday.io/projects?tag=raspberry%20pi)
10. [Jeff Geerling's YouTube Channel](https://www.youtube.com/c/JeffGeerling) - Jeff has a lot of videos based on Raspberry Pi projects along with some unusual testing like attempting to get modern graphics cards to function on the Pi (spoiler alert he's had very limited success with this). He also has a series on Ansible, Kubernetes and more.
11. [Jeff Geerling's Pi PCI site](https://pipci.jeffgeerling.com/)
12. [N-O-D-E](https://www.youtube.com/c/NODEtv)
13. [NetworkChuck's YouTube Channel](https://www.youtube.com/c/NetworkChuck/videos) - has some good pi videos
14. [Retropie](https://retropie.org.uk/) - If you want to relive the glory days of retro games
15. [Setting up VMware on a Raspberry Pi 4](https://www.experts-exchange.com/articles/34931/HOW-TO-Install-and-Configure-VMware-vSphere-Hypervisor-7-0-ESXi-7-0-ARM-on-a-Raspberry-Pi-4.html)  
16. [TuringPi](https://turingpi.com/v2/)
17. [Pinout](https://pinout.xyz/)
18. [SBRL blog](https://starbeamrainbowlabs.com/blog/article.php?article=posts/242-Learn-Your-Terminal.html)  

*Resources compiled by various Freeside members, a huge thanks to everyone who helped!*
