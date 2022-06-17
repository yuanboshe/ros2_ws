# FROM yuanboshe/ros2:galactic-novnc AS base-image
FROM yuanboshe/ros2:galactic-gazebo AS base-image
FROM base-image

# ** [Optional] Uncomment this section to install additional packages. **
#
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get update \
#    && apt-get -y install --no-install-recommends <your-package-list-here> \
#    #
#    # Clean up
#    && apt-get autoremove -y \
#    && apt-get clean -y \
#    && rm -rf /var/lib/apt/lists/*
# ENV DEBIAN_FRONTEND=dialog

# Set up auto-source of workspace for ros user
ARG WORKSPACE
RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" \
    >> /home/aicrobo/.bashrc

WORKDIR /home/aicrobo/ros2_ws
USER aicrobo

# uncomment if use novnc
# RUN mkdir -p /home/aicrobo/.config/tint2
# COPY --from=base-image /root/.config/tint2/tint2rc /home/aicrobo/.config/tint2/
