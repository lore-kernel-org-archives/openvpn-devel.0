Date: Mon, 20 Sep 2021 17:20:51 +0200 (CEST)
Message-Id: <202109201520.18KFKpqv091396@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210904095629.6273-5-a@...2181...>
References: <20210904095629.6273-5-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: do not include --cipher value
 in data-ciphers
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

As discussed on IRC, the Changes.rst entry was extended, and the
--cipher entry in the manpage (doc/man-sections/protocol-options.rst) 
was replaced with the new text.  I'm not sure if it is clear enough
now, so I susggest we revisit the whole "document ciphers and NCP" 
topic in the "pre-release" phase for 2.6 - Richard's help would 
certainly be most welcome there.

The code itself looks reasonable.  Some basic tests with my current
t_client rig confirms that it broke all the "--cipher BF-CBC" tests
(that had this explicitly added because NCP broke the frame stuff,
thus "big packets").  Adding "--data-ciphers BF-CBC" fixed those
tests, and so did "--compat-mode 2.4.0".

commit 65f6da8eeb84fbcea357765e13fa73d0169a143c
Author: Antonio Quartulli
Date:   Sat Sep 4 11:56:26 2021 +0200

     do not include --cipher value in data-ciphers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210904095629.6273-5-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22799.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


