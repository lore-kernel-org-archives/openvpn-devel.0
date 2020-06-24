Date: Wed, 24 Jun 2020 10:16:36 +0200 (CEST)
Message-Id: <202006240816.05O8Ga6L048220@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1592953354.2103.3.camel@...2316...>
References: <1592953354.2103.3.camel@...2316...>
Subject: [Openvpn-devel] [PATCH applied] engine-key tests: make
 check_engine_keys.sh work with --enable-small
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
To: James Bottomley <James.Bottomley@...2316...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Looks reasonable and does not break anything that already worked.

I could reproduce the --enable-small breakage with FreeBSD / 1.0.2s
here (interesting enough, not with Linux and 1.1.1*), and can confirm
that the patch fixes things.

Your patch has been applied to the master branch.

commit 013498ddfe0a2b7f8986e9edac2b9f062bdd5fd7 (HEAD -> master)
Author: James Bottomley <James.Bottomley@...2316...>
Date:   Tue Jun 23 16:02:34 2020 -0700

    engine-key tests: make check_engine_keys.sh work with --enable-small
    
    Signed-off-by: James Bottomley <James.Bottomley@...2316...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1592953354.2103.3.camel@...2316...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20102.html
    Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


