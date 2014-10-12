Date: Sun, 12 Oct 2014 21:59:19 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20141012195919.GU3738@...1819...>
References: <20141009214049.GB4106@...1818...>
	<5437B156.1020408@...1114...>
MIME-Version: 1.0
In-Reply-To: <5437B156.1020408@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Fix temporary file leak
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

David Sommerseth, le Fri 10 Oct 2014 12:13:42 +0200, a =E9crit :
> I think it would be better to move the unlink() code from
> multi_client_connect_post() into multi_connection_established(), where
> these temp files are created.  This makes the code clearer and easier to
> understand.

Right, how about this?

Samuel

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 5910154..25e7384 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1459,10 +1465,6 @@ multi_client_connect_post (struct multi_context *m,
 			     option_types_found,
 			     mi->context.c2.es);
=20
-      if (!platform_unlink (dc_file))
-	msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
-	     dc_file);
-
       /*
        * If the --client-connect script generates a config file
        * with an --ifconfig-push directive, it will override any
@@ -1705,6 +1707,11 @@ multi_connection_established (struct multi_context *=
m, struct multi_instance *mi
 	      multi_client_connect_post (m, mi, dc_file, option_permissions_mask,=
 &option_types_found);
 	      ++cc_succeeded_count;
 	    }
+
+	  if (!platform_unlink (dc_file))
+	    msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
+		 dc_file);
+
         script_depr_failed:
 	  argv_reset (&argv);
 	}
@@ -1758,6 +1765,11 @@ multi_connection_established (struct multi_context *=
m, struct multi_instance *mi
 	    }
 	  else
 	    cc_succeeded =3D false;
+
+	  if (!platform_unlink (dc_file))
+	    msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
+		 dc_file);
+
         script_failed:
 	  argv_reset (&argv);
 	}

