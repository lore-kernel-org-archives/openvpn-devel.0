Date: Sun, 19 Apr 2026 16:08:50 +0200 (CEST)
Message-Id: <202604191408.63JE8oiQ055898@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260414055900.17132-1-gert@...1296...>
References: <20260414055900.17132-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Inlined credentials: read
 missing password from management interface
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

The original commit looked so simple and straightforward, but these
user-password-things never are... so thanks for fixing that omission.
I have not tested it, but if Arne ACKs it - and the code looks more
logical now, just using "password_from_stdin" as an indicator, not
multiple nested variants.

I'm not sure if this could be considered a "bug", but it's definitely
irritating behaviour for GUI users ("no credentials in file" leads to
"both are queried from mgmt" while "username inlined" leads to "password
queried from console only") so for a low minor version number, this
definitely qualified as "we want to fix this in the current release".

Your patch has been applied to the master and release/2.7 branch.

commit 287acce1acaad25a92f2112e967b9686418ef72a (master)
commit b450414d10309575c28ce00f175e8374e0e99480 (release/2.7)
Author: Selva Nair
Date:   Tue Apr 14 07:58:54 2026 +0200

     Inlined credentials: read missing password from management interface

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1599
     Message-Id: <20260414055900.17132-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36608.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


