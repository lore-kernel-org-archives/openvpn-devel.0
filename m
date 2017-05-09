From: David Sommerseth <davids@...515...>
Date: Tue,  9 May 2017 15:19:26 +0200
Message-Id: <20170509131926.21584-1-davids@...515...>
In-Reply-To: <1494279878-24601-1-git-send-email-steffan@...1856...>
References: <1494279878-24601-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Restore pre-NCP frame
	parameters for new sessions
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
To: openvpn-devel@lists.sourceforge.net, Steffan Karger <steffan@...1856...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

As mentioned, code looks sane + Arne and some users on the Trac ticket have
tested this as well.  So ACK from me as well.

Your patch has been applied to the following branches

commit 9900e023bcc49964d33e6f22c2b6223f8932acf8  (master)
commit 03d01f4f69cfc6768343b9f0f2dde2049e4882d2  (release/2.4)
Author: Steffan Karger
Date:   Mon May 8 23:44:38 2017 +0200

     Restore pre-NCP frame parameters for new sessions

     Trac: #879
     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1494279878-24601-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14589.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEcHCAAoJEIbPlEyWcf3yrZoP/05MaZIrD1NCzhfUkYmL8t18
eUGCBJUkDjr9tg+OhPhf5e/axf4GKzwBcDFZTiqdtXj+bntz/WXJp+ad4HAlwXmE
zfOKrwtIh8oqjXeyf9J9cRQJlLACGnzf/mfJet1uMssoTi4yoK8MspSbk8kdA3Nn
hEMINxKb+h/byZHjifNT25ZLB1x3gqzVrcvnN2afYQTGgt4BAEQBiVDK8fATh5Si
tqW7utXBYTOUepdm/uN9/2bpWLmG/HGzZR8AebsLRGb/xZhZKIaVP7+a3RUzPWw+
ljFvoVJlo8rcj91jWyQY/4nS2ULlFJ4kbKlwPaey0eNlPqtz+XO5uynBWi6AhNEN
+e5Xurs8D93pasfNzFAmi0pa7n92D42VLq1NR1qSfhf958/9rEaEnTd4W456C8Kh
iWd6NpbosQI0KhJLjnLCymMdD6WcH3yqvIxhJazMdmJICzCeIvPH7/rgtoUdmwPD
Gp5t6GtkCI9kKus9soWY0W2hQhIRXpO6IeKncRzjvjIhOSoThxMWelVbchtShOhd
0MQkxOZmYkjj5dXvVm6KZT+Y3CQxxOgqLvtAwfxn/35Uw9oayu1qfiUGJqZpt6wF
24FxyllopXQXK2qe35rZUDN1mNNkusO6q7iv78z2FbD7n9r/9LJBsuxDngvN/3ok
9fOG7apJJLSD0w+8J55v
=dhej
-----END PGP SIGNATURE-----

