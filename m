Date: Fri, 19 Aug 2022 19:04:52 +0200 (CEST)
Message-Id: <202208191704.27JH4qSZ095097@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220810153006.18860-1-maximilian.fillinger@...2507...>
References: <20220810153006.18860-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Don't undo ifconfig on exit if
 it wasn't done
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I had to apply a bit of pressure to get the patch to apply - the 
context in tun.c got changed ( || TARGET_FREEBSD) in the meantime...
fairly trivial, and no actual code change.

Pushed to the new and renovated buildbot army, to see if it would break
any platforms (very convenient, this ;-) ).  Didn't!  Thanks for the v6
update!

The change is as we have discussed, and I still think it's a good and
clean way forward.  The "undo_ifconfig_ipv4() / _ipv6()" functions
are as they have been before (except that they now get compiled for
all platforms except WIN32 - the "linux only" part was a 2.5.0 oversight),
and the calls moved 1:1 from (TARGET_LINUX) close_tun() to a new
undo_ifconfig() function.  tun.c is still a mess, but this helps a bit.

While staring at the diff, I kicked a spurious blank line from the
end of undo_ifconfig()... :-)


I'm a bit unsure if we want to pull this up to release/2.5 - it won't
apply "as is" (due to all the DCO bits around it), but the actual change
could be done the same.  It's a bugfix, and brings back the 2.4 
"undo ifconfig" behaviour to all non-linux/non-Win32 platforms 
(which was an unintended change in 2.5.0).  So maybe we should?


Your patch has been applied to the master branch.

commit 0c4d40cb838eb0fad4a82bbed1198f6d359d445a
Author: Max Fillinger
Date:   Wed Aug 10 17:30:06 2022 +0200

     Don't undo ifconfig on exit if it wasn't done

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220810153006.18860-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24860.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


