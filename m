Message-ID: <4BC5A960.40306@...1114...>
Date: Wed, 14 Apr 2010 13:39:12 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1269951178-30419-1-git-send-email-dazo@...384...>	<4BBE3205.1040303@...1114...>	<p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>	<4BC47655.10101@...1114...>	<t2o9e0cf0bf1004130659l5c4a8dc2o6eab22db336078be@...278...>
	<4BC580D8.5040304@...515...>
In-Reply-To: <4BC580D8.5040304@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
 ./configure information to --version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/04/10 10:46, Samuli Seppänen wrote:
> 
>> First of all, let's bring in the history.  This feature was discussed in
>> the weekly meeting February 26, 2010.  See the chat log at [1], around
>> the time stamp 20:45:15.
>>
>>> David, IRC is not a development tool, it is sync tool that require all
>>> to be available at the same time, which is never the case. I don't
>>> understand why you took this approach, but its down-side is that
>>> people discover such commits later on.
>>
> There are several good reasons why we do use IRC as a development tool.
> First, it's the best/only available way to get James' input into
> "testing" development. Second, many patches have fail to receive an
> ACK/NACK or even any comments in the mailing list discussions. It's this
> kind of patches which are discussed in the meetings and more often than
> not we've managed to get an ACK/NACK for them.

It should also be said that discussed patches need to be posted to the
mailing list either before or after the meeting to get the final
ACK/NACKs.  In the case of being sent after a meeting, the patch still
needs to receive a public ACK, preferably on the ML.  But if there are
no response on the ML, it will be brought up for discussion on a later
IRC meeting.

So it is fair to say that IRC meetings alone do not decide which patches
are accepted or not.  Patches are brought up to discussions in those
meetings just because the feedback on the ML is lacking.

Further, I do not accept patches which has not been through the mailing
list and have received ACKs.  And I usually tend to let it go a little
while after the patch has been submitted before I suggest them for the
meeting agenda.  If the meeting minutes after this process says a patch
got an ACK, that is the same for me as if one of the meeting
participants afterwords replies to the patch, saying ACK.  I anyway do
add in the final commit logs who ACKed which patches.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvFqV4ACgkQDC186MBRfrqoBgCeJXJSogc3gcuWiqDdTxsaVThM
e+cAnA1pVW+JomiLDBK+DT0FNJksVpbX
=BaYH
-----END PGP SIGNATURE-----

