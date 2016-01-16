Date: Sat, 16 Jan 2016 21:53:58 +0100 (CET)
Message-Id: <201601162053.u0GKrwrC062545@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1452436639-16838-1-git-send-email-steffan@...1856...>
References: <1452436639-16838-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: simplify crypto
	library configuration
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  I'm no autoconf expert, but it looks reasonable to me, and works on
my test system...  Samuli might have to check whether it affects/breaks
building for windows (but his buildslave will tell us in a few minutes :) ).

It does change behaviour in some cases - my polarssl build only set
POLARSSL_CFLAGS=-I..., and it still found the library - with this patch,
POLARSSL_LIBS=-lpolarssl is now needed as well.  But I think that was
the intended usage all the time ("if you set one, you need to set both"),
so I'm not complaining.

Your patch has been applied to the master branch.

commit 31b0bebef61413151af9ded55aa985798d4f7666
Author: Steffan Karger
Date:   Sun Jan 10 15:37:19 2016 +0100

     configure.ac: simplify crypto library configuration

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1452436639-16838-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10978
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


