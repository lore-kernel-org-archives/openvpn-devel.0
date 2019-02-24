From: Simon Rozman <simon@...2293...>
Date: Sun, 24 Feb 2019 19:15:04 +0100
Message-Id: <20190224181504.38328-1-simon@...2293...>
In-Reply-To: <20190117155829.GA92142@...1296...>
References: <20190117155829.GA92142@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add user manual and developer notes URL for
 tapctl.exe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch follows Gert's recommendations from [openvpn-devel].

Signed-off-by: Simon Rozman <simon@...2293...>
Message-ID: <20190117155829.GA92142@...1296...>
---
 src/tapctl/basic.h | 1 +
 src/tapctl/error.c | 1 +
 src/tapctl/error.h | 1 +
 src/tapctl/main.c  | 1 +
 src/tapctl/tap.c   | 1 +
 src/tapctl/tap.h   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index 3469cb1c..bfbcc30d 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -1,5 +1,6 @@
 /*
  *  basic -- Basic macros
+ *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
diff --git a/src/tapctl/error.c b/src/tapctl/error.c
index 42ab6ccb..d1f77d20 100644
--- a/src/tapctl/error.c
+++ b/src/tapctl/error.c
@@ -1,5 +1,6 @@
 /*
  *  error -- OpenVPN compatible error reporting API
+ *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index 1ac9b835..924cbbe8 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -1,5 +1,6 @@
 /*
  *  error -- OpenVPN compatible error reporting API
+ *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 5e6e1752..295366b4 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -1,5 +1,6 @@
 /*
  *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index ba80237f..b2cb2dca 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -1,5 +1,6 @@
 /*
  *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 39dc28b0..c09c4766 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -1,5 +1,6 @@
 /*
  *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
-- 
2.19.0.windows.1


