Date: Thu, 20 Jan 2022 16:35:43 +0100 (CET)
Message-Id: <202201201535.20KFZhBF002365@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-10-selva.nair@...277...>
References: <20211214165928.30676-10-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow management client to
 announce pss padding support
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

Client-tested with OpenSSL 1.1.1 and 3.0.1.

This patch looks trivial enough, but the intricacies of all these
flag bits and padding are well beyond me :-) - good that Arne tested
all this for real.

Fixed one remaining occurence of "hashlag" in the commit message.

Your patch has been applied to the master branch.

commit a04e3ac04740129bc1574fa3f1a67fdad942ff14
Author: Selva Nair
Date:   Tue Dec 14 11:59:19 2021 -0500

     Allow management client to announce pss padding support

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-10-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23430.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


