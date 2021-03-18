Date: Thu, 18 Mar 2021 14:21:02 +0100 (CET)
Message-Id: <202103181321.12IDL2VF012379@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210317181153.83716-1-juliusz@...2525...>
References: <20210317181153.83716-1-juliusz@...2525...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support for wolfSSL in OpenVPN
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
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have not tested actual WolfSSL builds, but done a quick compile test
to see if it would break old/new openssl or old/new mbedtls configure
runs.  All works :-)

commit f6dca235ae560597a0763f0c98fcc9130b80ccf4
Author: Juliusz Sosinowicz
Date:   Wed Mar 17 19:11:53 2021 +0100

     Support for wolfSSL in OpenVPN

     Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210317181153.83716-1-juliusz@...2525...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21686.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


