Date: Wed, 5 May 2021 22:11:39 +0200 (CEST)
Message-Id: <202105052011.145KBdE5098680@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201002215146.31324-1-themiron@...2010...>
References: <20201002215146.31324-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add CRL extractor script for
 --crl-verify dir mode
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

We discussed this in the community meeting today, and came to the
conclusion that this is a nice and helpful addition.  It could be
argued that python is somewhat heavy to "run an openssl binary and
do something with the result", but it's neither the first nor last
python script in our repo, and "have a script" is better than "I could
write one in shell" :-)

I have not actually tested the script.  David has taken a look and
said it looks reasonable.  Rules for contrib/ are not as strict as
for "openvpn main source", so that's good enough.

Thanks.

Your patch has been applied to the master branch.

commit 4c2549ba5d8b1b449acc62a46692345710965647
Author: Vladislav Grishenko
Date:   Sat Oct 3 02:51:46 2020 +0500

     Add CRL extractor script for --crl-verify dir mode

     Signed-off-by: Vladislav Grishenko <themiron@...2010...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201002215146.31324-1-themiron@...2010...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21154.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


