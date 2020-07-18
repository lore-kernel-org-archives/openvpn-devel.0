Date: Sat, 18 Jul 2020 09:41:46 +0200 (CEST)
Message-Id: <202007180741.06I7fk9c028482@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200717212820.8998-1-a@...2181...>
References: <20200717212820.8998-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: don't leak inline'd
 key material in logfile
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

Acked-by: Gert Doering <gert@...1296...>

Stared-at-code (clever macro!) and tested :-) - now I see

2020-07-18 09:39:52 us=800872   ca_file = '[INLINE]'
2020-07-18 09:39:52 us=800880   cert_file = '[INLINE]'
2020-07-18 09:39:52 us=800886   priv_key_file = '[INLINE]'

what used to be actual file content.

Thanks for the quick fix!

Your patch has been applied to the master branch (while a bugfix,
the offending code is not in 2.4, so no fix needed there).

commit 19fab1f6cf71715f84d09d6a8b49698b0ae42cd1
Author: Antonio Quartulli
Date:   Fri Jul 17 23:28:20 2020 +0200

     options: don't leak inline'd key material in logfile

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200717212820.8998-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20472.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


