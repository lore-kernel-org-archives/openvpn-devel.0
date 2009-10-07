Date: Wed, 7 Oct 2009 11:17:42 +0200
From: richard lucassen <mailinglists@...673...>
Message-Id: <20091007111742.0742a7c5.mailinglists@...673...>
Mime-Version: 1.0
Subject: [Openvpn-devel] man page improvement
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

IMHO the man page is not very clear about the option "down-pre". And if
the option "down-pre" is used without a the "down" parameter, OpenVPN
is not complaining (it should IMHO). E.g.:

down-pre /path/to/script.sh

is accepted, but not executed. I just posted this on the users list:

##################################################################
<quote>

[..]

> in other words, you have to specify
>   down /etc/openvpn/down/down.script.sh
>   down-pre
> to get the 'down' script to be called before the TAP device is closed.

"down-pre: to get the 'down' script to be called before the TAP device
is closed"

Apparently you read other things than I do. I don't read here:

"down-pre: to get the 'down' script to be called before the TAP device
is closed. This option is an option without parameters and must be used
in conjunction with the "down" parameter"

An example would certainly tell more than a thousand words:
down /path/to/script.sh
down-pre

Another thing: normally OpenVPN refuses to start when it detects errors
in the config file. I'd expect:

[ERROR] "down-pre": missing "down" command

</quote>
##################################################################

I can't find a bugzilla part on your website, so I post it on this list.

HTH,

R.

-- 
___________________________________________________________________
It is better to remain silent and be thought a fool, than to speak
aloud and remove all doubt.

+------------------------------------------------------------------+
| Richard Lucassen, Utrecht                                        |
| Public key and email address:                                    |
| http://www.lucassen.org/mail-pubkey.html                         |
+------------------------------------------------------------------+

