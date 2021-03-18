Date: Thu, 18 Mar 2021 08:12:53 +0100 (CET)
Message-Id: <202103180712.12I7CrKG064224@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210317223448.1278818-1-tincanteksup@...277...>
References: <20210317223448.1278818-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not print Diffy Hellman
 parameters file to log file
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
To: Richard Bonhomme <tincanteksup@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.5 branch.

I've corrected the spelling of "Diffy" to "Diffie", according to

  https://en.wikipedia.org/wiki/Diffie-Hellman_key_exchange

I have not tested this further than "it compiles".

commit 4170da0778b926cea748c319163fdcfc7c6bc445 (master)
commit c8a72bbfbf16fa87c18c2e92c467587833b611e9 (release/2.5)
Author: Richard Bonhomme
Date:   Wed Mar 17 22:34:48 2021 +0000

     Do not print Diffy Hellman parameters file to log file

     Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210317223448.1278818-1-tincanteksup@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21688.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


