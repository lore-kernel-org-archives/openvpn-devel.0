Date: Mon, 20 Mar 2023 17:35:00 +0100 (CET)
Message-Id: <202303201635.32KGZ0qp066290@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230301135353.2811069-2-arne@...1227...>
References: <20230301135353.2811069-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make sending plain text control
 message session aware
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Discussed this at length with Arne - the change looks very big, but
most of it is "change of calling conventions", passing in "session"
instead of "multi" (session being c2.tls_multi->session[$key], TM_ACTIVE
for most of the invocations).

The interesting things are more subtle :-) -

  - send_auth_failed() will now call send_control_channel_string_dowork()
    twice, for TM_INITIAL and TM_ACTIVE, to deliver the AUTH_FAILED
    message to all sessions, active and pending (and reschedule, as
    that call is in send_control_channel_string() normally)

  - verify_user_pass_script() calls key_state_check_auth_pending_file()
    with "session" (in additon to "multi"), which can be TM_INITIAL
    or TM_ACTIVE, depending on the context.  This then calls
    send_auth_pending_messages() to send the "auth pending" message
    to the appropriate context.

  - management_client_pending_auth() will use the TM_INITIAL or TM_ACTIVE
    session depending on the new "KID" argument (== mda_key_id)


While staring at the code, I've fed this to the server testbed, which
does quite a bit of authentication and async/deferred authentication
testing, and all passed.  It does not yet do client-side delayed auth
testing (need a proper client testbed), so I can not attest that it
fixes the problems observed in #256 - but I can attest that it's not
breaking anything we currently test for.


I have added a "Github: ..." tag to the commit message, and reworded
doc/management-notes.txt a bit, as agreed on IRC.  In the 2.6 branch,
the "Changes.rst" entry was moved to a new "2.6.2" section.

Your patch has been applied to the master and release/2.6 branch.

commit a261e173341f8e68505a6ab5a413d09b0797a459 (master)
commit da083c3b9bc1b5720a4dcbef9c32bbbbec0dcce6 (release/2.6)
Author: Arne Schwabe
Date:   Wed Mar 1 14:53:53 2023 +0100

     Make sending plain text control message session aware

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230301135353.2811069-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26320.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


