Message-ID: <4C8F79BC.7090602@...1114...>
Date: Tue, 14 Sep 2010 15:33:48 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <54C854C313159D429F344FB1DE1A6526110D96A5@...1403...>	<4C8E9E7B.9020308@...1299...>	<20100914074032.GA10703@...1296...>	<4C8F3C04.8020904@...1147...>
	<20100914113722.GB10703@...1296...>
In-Reply-To: <20100914113722.GB10703@...1296...>
Subject: Re: [Openvpn-devel] Enhancements.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/09/10 13:37, Gert Doering wrote:
> Hi,
> 
> On Tue, Sep 14, 2010 at 11:10:28AM +0200, Jan Just Keijser wrote:
>>>          if (buf_string_match_head_str (&buf, "AUTH_FAILED"))
>>>            receive_auth_failed (c, &buf);
>>>          else if (buf_string_match_head_str (&buf, "PUSH_"))
>>>            incoming_push_message (c, &buf);
>>>          else if (buf_string_match_head_str (&buf, "RESTART"))
>>>            server_pushed_restart (c, &buf);
>>>          else
>>>            msg (D_PUSH_ERRORS, "WARNING: Received unknown control 
>>>            message: %s",
>>> BSTR (&buf));
>>
>> is the control message stage early enough? that means authentication has 
>> been completed, and the client_connect script has been run (or am I 
>> mistaken? 
> 
> I'm not absolutely sure at what time these messages can be sent.  But
> most likely you're right, you want this before running client-connect.
> 
> Someone around who fully understands the session flow...?
> 

Taken completely from memory, the PUSH_REQ phase comes in _after_ the
authentication process.  But, I also believe it comes after
OPENVPN_PLUGIN_CLIENT_CONNECT phase, as that plug-in hook can push
config settings to the client dynamically.  And of the
OPENVPN_PLUGIN_CLIENT_CONNECT hook sends a rejection, the connection is
dropped.

Unless somebody else chimes in before I've been able to double check it,
I'll do some more checks here.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkyPeboACgkQDC186MBRfrrl2wCgqL7uNdJaj2N9nZykQ+rUoo7v
Zp0An3c5ICN6Tokyvr7hIrkOYrgsv10R
=CX8v
-----END PGP SIGNATURE-----

