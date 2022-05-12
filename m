Date: Thu, 12 May 2022 08:32:49 +0200 (CEST)
Message-Id: <202205120632.24C6Wn76014604@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220503002840.295-1-lstipakov@...277...>
References: <20220503002840.295-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix M_ERRNO behavior on Windows
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I've added the S-O-B line according to our developer documentation.

I have come late to the party, but really, code like this should be
avoided:

+        bool unreachable = error_code ==
+#ifdef _WIN32
+            WSAENETUNREACH;
+#else
+            ENETUNREACH;
+#endif

what is wrong writing this as follows?

+#ifdef _WIN32
+        bool unreachable = (error_code == WSAENETUNREACH);
+#else
+        bool unreachable = (error_code == ENETUNREACH);
+#endif

one line *less*, and very clear what happens in both branches, not
"old style openvpn contortions with #ifdef in the middle of an 
expression".

Also, assignments of the type "a = b == c;" should use brackets, always 
- even if the C compiler understands what this code does, humans need 
extra brain cycles to make sense of it.

commit 54800aa975418fe3570f3206a5f9b277dc59bd47
Author: Lev Stipakov
Date:   Tue May 3 03:28:40 2022 +0300

     Fix M_ERRNO behavior on Windows

     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20220503002840.295-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24270.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


