Date: Sat, 12 Oct 2013 18:25:56 +0200
From: Davide Brini <dave_br@...1278...>
In-Reply-To: <5252FB07.3070309@...1832...>
References: <go9r6cg1wcfh4lpwb9664gdd.1381086064578@...1753...>
	<5252FB07.3070309@...1832...>
Mime-Version: 1.0
Message-ID: <0MUUWN-1VMPIC2zpb-00REku@...1825...>
Subject: Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Max Muster <Max.Muster@...1832...>
Cc: openvpn-devel@lists.sourceforge.net

So here we go, your points are all valid. The patch you attached has a
spurious line, or maybe it's just my client that doesn't show it correctly,
I see

@@ -5835,7 +5872,12 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       if (p[1])
 	{
-	  options->auth_user_pass_file = p[1];
+          options->auth_user_pass_file = p[1];
+          if (streq (p[1], INLINE_FILE_TAG) && p[2])
+            { msg (M_WARN, "options.c \n  !!!SETTING !!! \n_ +5930,12 @@ add_optio"); 
+              options->auth_user_pass_file = "stdin";
+              options->auth_user_pass_file_inline = p[2];
+            }
 	}

I don't think the !!!SETTING !!! line should be there, so I'm going
to send a revised patch in a few minutes which essentially includes all your
suggestions (and is against master, I'm not sure yours was against master).
I'm also citing your contribution in the new text, which I think is
deserved.

Thanks also for showing that there is at least another person besides me
interested in this functionality!

-- 
D.

