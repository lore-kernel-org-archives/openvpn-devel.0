From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 11 Aug 2011 15:19:46 +0000
Message-Id: <1313075986-26862-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] remove legacy code to query IE proxy
	information
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The code in ieproxy.[ch] is not used anywhere in OpenVPN anymore.
So, there's no need to keep it.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 Makefile.am |    1 -
 ieproxy.c   |  146 -----------------------------------------------------------
 ieproxy.h   |   24 ----------
 proxy.c     |    5 --
 4 files changed, 0 insertions(+), 176 deletions(-)
 delete mode 100644 ieproxy.c
 delete mode 100644 ieproxy.h

diff --git a/Makefile.am b/Makefile.am
index 32b40bb..266a5af 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -127,7 +127,6 @@ openvpn_SOURCES = \
 	pool.c pool.h \
 	proto.c proto.h \
 	proxy.c proxy.h \
-	ieproxy.h ieproxy.c \
         ps.c ps.h \
 	push.c push.h \
 	pushlist.h \
diff --git a/ieproxy.c b/ieproxy.c
deleted file mode 100644
index 3099870..0000000
--- a/ieproxy.c
+++ /dev/null
@@ -1,146 +0,0 @@
-/*
- *  Copyright (C) 2004 Ewan Bhamrah Harley <code@...1494...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include "syshead.h"
-
-#ifdef WIN32
-
-#include <wininet.h>
-#include <malloc.h>
-
-LPCTSTR getIeHttpProxyError=NULL;
-
-/* getIeHttpProxy fetches the current IE proxy settings for http */
-
-LPCTSTR getIeHttpProxy()
-{
-  DWORD psize=0;
-  INTERNET_PROXY_INFO *pinfo;
-  LPTSTR proxyString;
-  LPTSTR p;
-  LPTSTR q;
-  unsigned int len;
-	
-  /* first see how big a buffer we need for the IPO structure */
-  InternetQueryOption(NULL, INTERNET_OPTION_PROXY, NULL, &psize);
-  if(!psize)
-  {
-    getIeHttpProxyError="InternetQueryOption failed to return buffer size";
-    return(NULL);
-  }
-
-  /* allocate memory for IPO */
-  pinfo =  malloc (psize*sizeof(TCHAR));
-  if (pinfo == NULL)
-  {
-    getIeHttpProxyError="malloc failed (1)";
-    return(NULL);
-  }
-
-  /* now run the real query */
-  if(!InternetQueryOption(NULL, INTERNET_OPTION_PROXY, (LPVOID) pinfo, &psize))
-  {
-    getIeHttpProxyError="InternetQueryOption() failed to find proxy info";
-    free(pinfo);
-    return(NULL);
-  }
-
-
-  /* see what sort of result we got */
-	
-  if(pinfo->dwAccessType == INTERNET_OPEN_TYPE_DIRECT)
-  {
-    /* No proxy configured */
-    free(pinfo);
-    return("");
-  }
-  else if(pinfo->dwAccessType == INTERNET_OPEN_TYPE_PROXY)
-  {
-    /* we have a proxy - now parse result string */
-    /* if result string does NOT contain an '=' sign then */
-    /* there is a single proxy for all protocols          */
-    for (p=(LPTSTR)pinfo->lpszProxy; *p && *p != '='; p++);
-    if(!*p)
-    {
-      /* single proxy */
-      /* allocate a new string to return */
-      len = 1+strlen(pinfo->lpszProxy);
-      proxyString = malloc (len*sizeof(TCHAR));
-      if (proxyString == NULL)
-      {
-        getIeHttpProxyError="malloc failed (2)";
-        free(pinfo);
-        return(NULL);
-      }
-      strncpy(proxyString, pinfo->lpszProxy,len);
-      proxyString[len]=0;
-      free(pinfo);
-      return(proxyString);
-    }
-    else
-    {
-      /* multiple space seperated proxies defined in the form */
-      /* protocol=proxyhost[:port]                            */
-      /* we want the one marked "http=", if any.              */
-      p=(LPTSTR)pinfo->lpszProxy;
-      while(*p && strncmp(p, "http=", 5))
-      {
-        for(; *p && *p != ' '; p++);
-        if(*p) p++;
-      }
-      if(*p)
-      {
-        /* found the proxy */
-        p+=5;
-        for(q=p; *q && *q != ' '; q++);
-        /* allocate a buffer for the proxy information */
-        len=1+(q-p);
-        proxyString=malloc(len*sizeof(TCHAR));
-        if(proxyString==NULL)
-        {
-          getIeHttpProxyError="malloc failed (3)";
-          free(pinfo);
-          return(NULL);
-        }
-        strncpy(proxyString, p, len);
-        proxyString[len]=0;
-        free(pinfo);
-        return(proxyString);
-      }
-      else
-      {
-        /* No http proxy in list */
-        free(pinfo);
-        return("");
-      }
-    }
-  }
-  else
-  {
-    /* InternetQueryOption returned a proxy type we don't know about*/
-    getIeHttpProxyError="Unknown Proxy Type";
-    free(pinfo);
-    return(NULL);
-  }
-}
-#else
-#ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
-static void dummy (void) {}
-#endif
-#endif				/* WIN32 */
diff --git a/ieproxy.h b/ieproxy.h
deleted file mode 100644
index 0786c05..0000000
--- a/ieproxy.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *  Copyright (C) 2004 Ewan Bhamrah Harley <code@...1494...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __GETIEHTTPPROXY__
-#define __GETIEHTTPPROXY__
-extern LPTSTR getIeHttpProxyError;
-LPCTSTR getIeHttpProxy();
-#endif
diff --git a/proxy.c b/proxy.c
index fce64a1..b00532c 100644
--- a/proxy.c
+++ b/proxy.c
@@ -34,11 +34,6 @@
 #include "base64.h"
 #include "httpdigest.h"
 #include "ntlm.h"
-
-#ifdef WIN32
-#include "ieproxy.h"
-#endif
-
 #include "memdbg.h"
 
 #ifdef ENABLE_HTTP_PROXY
-- 
1.7.5.4


