Date: Tue, 27 Dec 2022 09:31:30 +0100 (CET)
Message-Id: <202212270831.2BR8VUQ3085016@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210907223126.8440-1-selva.nair@...277...>
References: <20210907223126.8440-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add remote-count and
 remote-entry query via management
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

I had conflicts in doc/management-notes.txt (the context leading to
this in the patch is way different, and not in my tree?!), and uncrustify
had some whitespace complaints - fixed the conflict, and the complaints.

Stare-at-code looks reasonable ("and it has an ACK from Arne").

I have tested this (with a small .ovpn with only a handful of remotes in),
and it seems to do what it says on the lid.

One thing that confuses me slightly - either I am holding this wrong, or
I don't understand how this is supposed to work...

 - I run the client with --management-hold
 - connect to the management interface
 - try remote-entry-count ...

    >INFO:OpenVPN Management Interface Version 4 -- type 'help' for more info
    >HOLD:Waiting for hold release:0
    remote-entry-count
    ERROR: The remote-entry-count command is not supported by the current daemon mode

 - do a hold release (openvpn connects to the first remote now), then try
   again...

    hold release
    SUCCESS: hold release succeeded
    remote-entry-count
    5
    END

 - looking at the code confirms that cb.remote_entry_count + *get is
   only initialized (init_management_callback_p2p()) when OpenVPN starts,
   well, initializing the actual P2P instance - so the code does what it
   is told, but I wonder if this feature should not help the GUI select
   one of the configs *before* OpenVPN starts connecting to the first
   remote?

Your patch has been applied to the master and release/2.6 branch.

commit 125263804701f9e62a5a27587e4ea6afdb21f54d ( master)
commit 5503b45e6666cc7a3f10dd1e6fb406ca487489bd (HEAD -> release/2.6)
Author: Selva Nair
Date:   Tue Sep 7 18:31:24 2021 -0400

     Add remote-count and remote-entry query via management

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210907223126.8440-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22815.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


