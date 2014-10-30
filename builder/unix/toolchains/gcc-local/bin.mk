################################################################
#
#        Copyright 2013, Big Switch Networks, Inc. 
# 
# Licensed under the Eclipse Public License, Version 1.0 (the
# "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at
# 
#        http://www.eclipse.org/legal/epl-v10.html
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied. See the License for the specific
# language governing permissions and limitations under the
# License.
#
################################################################

################################################################################
#
# GCC-Local Binary File Rules
#
################################################################################
MAKE_DIR=$(BINARY_DIR)
include $(BUILDER)/makedir.mk

ifdef DEBUG
DEBUG_FLAGS = -g
LINFO="[debug]"
else
LINFO="[release]"
endif

ifdef COVERAGE
COVERAGE_FLAGS := --coverage
endif

ifndef GCC_LN
ifdef CPP_FILES_PRESENT
GCC_LN := g++
else
ifdef GCC
GCC_LN := $(GCC)
else
GCC_LN := gcc
endif # GCC defined
endif # CPP file present
endif # GCC_LN defined

# Fixme
$(BINARY_DIR)/$(BINARY): $(BINARY)_LINK_LIBS=$(addprefix $(LIBRARY_DIR)/,$($(BINARY)_LIBRARIES))

$(BINARY_DIR)/$(BINARY): $($(BINARY)_LIBRARIES)
	@echo "    Linking$(LINFO): $(MODULE)::$(notdir $@)"
	$(VERBOSE)$(GCC_LN) $(DEBUG_FLAGS) $(COVERAGE_FLAGS) -o $@ -Wl,--start-group $($(BINARY)_LINK_LIBS) $($(BINARY)_EXTRA_LINK_LIBS) $(GLOBAL_LINK_LIBS) -Wl,--end-group $(LDFLAGS)
ifdef $(BINARY)_POST_BUILD
	$(VERBOSE)$($(BINARY)_POST_BUILD)
endif





