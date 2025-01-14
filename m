Date: Tue, 14 Jan 2025 18:17:30 +0100 (CET)
Message-Id: <202501141717.50EHHUBt045538@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241231204629.1210040-2-ben.boeckel@...2851...>
References: <20241231204629.1210040-2-ben.boeckel@...2851...>
Subject: [Openvpn-devel] [PATCH applied] Re: console_systemd: remove the
 timeout when using 'systemd-ask-password'
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
To: Ben Boeckel <ben.boeckel@...2851...>
Cc: openvpn-devel@lists.sourceforge.net

I have taken this from the mailing list, as it has a thread hanging off
it with an ACK in it - which is easier than making the gerrit submission
a mail again, so it has a message-id to link to.

Not much to test here - it's a trivial addition of an argv argument, and
if David says "this is good" then it is :-)  (gerrit build tests also
agree that it does not break anything).

Your patch has been applied to the master and release/2.6 branch
(it could be argued whether it's a bugfix or a feature).

commit 8084990ccecbf803498419e553bc1a6f073f8175 (master)
commit f67bd153a18192e0a8ed9b57738d8589f26369e3 (release/2.6)
Author: Ben Boeckel
Date:   Tue Dec 31 21:46:29 2024 +0100

     console_systemd: remove the timeout when using 'systemd-ask-password'

     Signed-off-by: Ben Boeckel <ben.boeckel@...2851...>
     Message-Id: <20241231204629.1210040-2-ben.boeckel@...2851...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30336.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


