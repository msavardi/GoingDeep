# GoingDeep

This is a practical codelab that follow the Data_Scientist_for_a_day <https://github.com/alessandroferrari/Data_Scientist_for_a_Day> with the aim to guide beginners from the discipline of machine learning and classification into the deep learning side, by means of open source tools. 

The tutorial lab explains you the tools that you need to understand in order to develop a classification solution of this kind. By completion of the source code, you will have a working solution for classifying on a kaggle competition dataset. The kaggle dataset competition is the London Data Science competition.

This tutorial is intended to be connected to the intorductory part that you could find here <https://github.com/alessandroferrari/Deep-learning-An-Historical-perspective-slides> and is based on the pycaffe notebook brewing-logreg.


## Docker
=============================
If you want to dive headfirst on the practical, or you were not able to set up a proper environment, there is also a docker already configured.

1. Install docker (for both Linux, Mac and Windows): https://docs.docker.com/engine/installation/
2. Point your shell (terminal, power shell or whatever) in this directory and then type: `docker build -t goingdeep .`
3. I suggest to follow this nice warm-up: https://docs.docker.com/, then in order to start the docker container type: `docker run -d -p 8888:8888 -v /your/directory/with/this/files:/workspace goingdeep`
5. Open your browser on http://localhost:8888, select `GoingDeep.ipynb` notebook and enjoy!



You are free to use this codelab for your seminars, for you courses or for your own education, but you have to give credits at the author for his work.
The copyright of this work is owned by the author Mattia Savardi.
All the materials are released with gpl-3.0 license, see <http://www.gnu.org/licenses/>.