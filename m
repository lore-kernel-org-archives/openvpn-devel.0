Date: Sat, 14 Oct 2023 18:06:59 +0200 (CEST)
Message-Id: <202310141606.39EG6xx1071482@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231009105518.34432-1-frank@...2641...>
References: <20231009105518.34432-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Print peer temporary key details
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Tested against the various OpenSSL/LibreSSL variants by pushing to
the buildbot army and GHA.

A minimal local tests shows the new addition to the "Control Channel:"
line...

old:
    Control Channel: TLSv1.2, cipher TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384, peer certificate: 2048 bit RSA, signature: RSA-SHA1

new:
    Control Channel: TLSv1.2, cipher TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384, peer certificate: 2048 bits RSA, signature: RSA-SHA1, peer temporary key: 256 bits ECprime256v1


Your patch has been applied to the master and release/2.6 branch.

commit 4e80aac451b99d5cc0b0cf268ca678e602959191 (master)
commit 1240d97cfe782fa7c3ed0ecadd4fee8a7d4ccc18 (release/2.6)
Author: Arne Schwabe
Date:   Mon Oct 9 12:55:18 2023 +0200

     Print peer temporary key details

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231009105518.34432-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27192.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


