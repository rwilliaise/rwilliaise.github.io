---
layout: page
---

<div style="text-align: center; padding-bottom: 1.5rem;">
  <a href="https://linkedin.com/in/rajaw">
    <i class="fa-brands fa-square-linkedin"></i>
  </a>
  <a href="https://github.com/rwilliaise">
    <i class="fa-brands fa-square-github"></i>
  </a>
</div>

<img src="{{ '/public/img/me.jpg' | absolute_url }}" width="400" style="float: right; padding-left: 10px;">

Hello, I'm Raja Williams. I'm an undergraduate at the University of Washington
pursuing Electrical and Computer Engineering, although I am generally interested
in all things space. I am currently on the [Society of Advanced Rocket
Propulsion (SARP)](https://sarpuw.com) on Payload and [Husky Satellite
Lab (HSL)](https://huskysat.org) working on FOUND.

In terms of areas of research I am interested in, I'm interested most in
guidance, navigation and control, thus far interacting the most with state
estimation and playing somewhat with attitude determination. I am also
interested in simulating many-body problems, and more generally, numerical
methods.

Outside of my work, I find time to hike and camp, and less often, I drum. Most
of my drumming experience is marching in high school in the [Seattle All City
Marching Band](https://www.allcityband.org) as a bass drum player. I also
frequently dabble in weightlifting.

# Brief list of projects
- ## SARP: Firmware for airbrakes payload (2025-)
  - Designed and coded a multi-threaded controller architecture in *C/C++* using
    *FreeRTOS*.
  - Created drivers with *FreeRTOS* thread-safety primitives in *C++* for the
    multiple sensors and chips on-board our hardware: BMP390, BMI088, etc.
  - Created a testing apparatus that connects directly to *MatLab* and
    *Simulink* and tests the airbrakes controller with simulation data.
  - Ported our airbrakes controller from initial draft designs in *MatLab* to a
    flight-ready *C++* implementation.
  - Designed and implemented a *Kalman filter* for fusing our noisy sensor data
    into one, not-that-noisy altitude estimate.
  - Used *SageMath* to symbolically compute the process noise covariance matrix
    for the *Kalman filter*.
  - Flew the airbrakes on a rocket! Spot the thin black stripe on the bottom
    half of Cherry Bomb below (April 11th, 2026).
![Airbrakes (the thin black portion near the bottom) flying on Cherry
Bomb]({{ '/public/img/sarp_airbrakes_launch.jpg' | absolute_url }})

- ## HSL: FOUND (2025-)
  - FOUND is an open-source close-range optical navigation system for CubeSats,
    primarily for determining the position of the satellite in orbit around
    GPS-denied environments (like the Moon).
  - Implemented an *edge detection* algorithm in *C++* that uses the *inertial
    symmetry* of a celestial body to estimate radius and choose lines to
    intersect.
    - We decided to not use this algorithm after figuring out that it's slow
      compared to more traditional algorithms.
  - Implemented a calculation of the *covariance matrix* of our system's
    output, for usage with state estimation systems (... like *Kalman filters*).

- ## GoGymi: Exam Preparatory Videos (2024)
  - GoGymi is a company in Switzerland that specializes in creating exam
    preparatory materials for students for the Gymnasium entrance exams.
  - I created a company-wide framework in *Python* to generate animated math
    videos under a unified theme using the *Manim* library.
  - Created a framework to automatically generate voiceovers synced with the
    videos with ElevenLabs *speech synthesis*.
  - Created *25+* videos explaining the solution to exam questions.
