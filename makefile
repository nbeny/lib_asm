# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nbeny <nbeny@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/11/27 00:56:40 by nbeny             #+#    #+#              #
#    Updated: 2018/01/05 10:19:09 by nbeny            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME	=		libasm.a

F_INC =		libasm.h
F_SRC =		syscall.s\
					hello_world.s
F_OBJ	= 	$(F_SRC:.s=.o)
F_EXE =		$(F_SRC:.s=)
F_SH		=		./bash.sh

NASM	=		nasm -f macho64
LD		=		ld -macosx_version_min 10.7.0 -lSystem

D_INC	=		./inc/
D_SRC	=		./src/
D_OBJ =		./obj/
D_EXE =		./exe/

CL_N	=		\033[0m
CL_R	=		\033[31m
CL_V	=		\033[32m
CL_J	=		\033[33m
CL_B	=		\033[34m
CL_C	=		\033[36m

CL_NS	=		\033[0;4m
CL_RS	=		\033[31;4m
CL_VS	=		\033[32;4m
CL_JS	=		\033[33;4m
CL_BS	=		\033[34;4m
CL_CS	=		\033[36;4m

CL_NG	=		\033[0;1m
CL_RG	=		\033[31;1m
CL_VG	=		\033[32;1m
CL_JG	=		\033[33;1m
CL_BG	=		\033[34;1m
CL_CG	= 	\033[36;1m

SRC		=		$(addprefix $(D_SRC), $(F_SRC))
OBJ		=		$(addprefix $(D_OBJ), $(F_OBJ))
EXE		=		$(addprefix $(D_EXE), $(F_EXE))
INC		= 	$(addprefix -I, $(D_INC))

.PHONY:	all clean fclean re run

all: $(NAME)

$(NAME): $(OBJ)
		echo "\n>$(CL_B)Build: $(CL_BG)$(NAME)$(CL_N)"
		ar rc $(NAME) $(OBJ)
		ranlib $(NAME)

$(OBJ)%.o:
		echo "$(CL_B)>Creat: Object file..$(CL_N)"
		mkdir -p $(D_OBJ)
		echo $@
		sh $(F_SH) "$(@)"

		# echo $>
		# $(NASM) -o $@ $^

clean:
		@echo "$(CL_R)>clean: $(CL_B)$(NAME) objects$(CL_N)"
		@rm -Rf $(D_OBJ)
		@rm -Rf $(D_EXE)

fclean: clean
		@echo "$(CL_R)>Delete: $(CL_B)$(NAME)$(CL_N)"
		@rm -f $(NAME)

re: fclean all

# run: $(OBJ) $(EXE)

# $(EXE)%: $(OBJ)%.o
# 		@echo "$(CL_V)>Creat: exec file..$(CL_N)"
# 		@mkdir -p $(D_EXE)
# 		@$(LD) $^ -o $@