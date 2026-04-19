// Copyright (c) 2026 Yuvraj Sakshith <ysakshith@gmail.com>

#include <Hypervisor/hv.h>
#include <stdio.h>
#include <sys/sysctl.h>
#include <sys/types.h>

#include "utils/pr.h"

int main() {

	int supported = 0;
	size_t size = sizeof(supported);

	if (sysctlbyname("kern.hv_support", &supported, &size, NULL, 0) != 0) {
		pr_err("Hypervisor not supported\n");
		return 1;
	}

}
