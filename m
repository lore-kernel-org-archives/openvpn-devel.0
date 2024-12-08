Date: Sun, 8 Dec 2024 15:20:57 +0100 (CET)
Message-Id: <202412081420.4B8EKvXV024670@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <d7c52354-8263-4423-8a4f-39bab3bd4d97@...68...>
References: <d7c52354-8263-4423-8a4f-39bab3bd4d97@...68...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix port-share journal doc
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
To: corubba <corubba@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Neither the code nor the manpage are particularily easy to digest, but
after staring at the code for quite a bit I have to agree with your
manpage fix.  The "to" bit goes into the filename...

  && !getsockname(cp->sd, (struct sockaddr *) &to.addr.sa, &dlen))
..
     const char *t = print_openvpn_sockaddr(&to, &gc);
     fnlen =  strlen(journal_dir) + strlen(t) + 2;
     snprintf(jfn, fnlen, "%s/%s", journal_dir, t);


.. and the "from" bit into the file content.

     if (!getpeername(pc->sd, (struct sockaddr *) &from.addr.sa, &slen)
..
     const char *f = print_openvpn_sockaddr(&from, &gc);
     if (write(fd, f, strlen(f)) != strlen(f))


Your patch has been applied to the master and release/2.6 branch (bugfix).

commit 9343cd101d74377305b96cd501b8659f64c70e46 (master)
commit 6d64fa4bfff935eb82f9786f709126ab02f0d8b3 (release/2.6)
Author: corubba
Date:   Sun Dec 8 00:19:35 2024 +0100

     Fix port-share journal doc

     Signed-off-by: corubba <corubba@...68...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <d7c52354-8263-4423-8a4f-39bab3bd4d97@...68...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30036.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


