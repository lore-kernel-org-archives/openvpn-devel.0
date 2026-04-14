Date: Tue, 14 Apr 2026 18:33:40 +0200 (CEST)
Message-Id: <202604141633.63EGXeGo032558@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260414125637.42082-1-frank@...2641...>
References: <20260414125637.42082-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: build: Use info fetched from
 version.m4
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
To: Luis Cruz <luis.cruz@...3019...>
Cc: openvpn-devel@lists.sourceforge.net

I have no idea what this does, and I do not use cmake - but Frank does,
and if he says "this is good", I won't object ;-) - also, buildbot
confirms that things still work... :-)

Your patch has been applied to the master and release/2.7 branch
("long term compat").

commit fbaf4a3837cddf73694e30a5b01e012e41246b79 (master)
commit de598fc931713f07b9efb36f5041123e46b72118 (release/2.7)
Author: Luis Cruz
Date:   Tue Apr 14 14:56:37 2026 +0200

     build: Use info fetched from version.m4

     Signed-off-by: Luis Cruz <luis.cruz@...3019...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1605
     Message-Id: <20260414125637.42082-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36612.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


