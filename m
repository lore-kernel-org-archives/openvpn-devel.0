Message-ID: <4CE1949C.6010707@...1114...>
Date: Mon, 15 Nov 2010 21:14:20 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1289808348-17463-1-git-send-email-dazo@...384...>	<1289808348-17463-3-git-send-email-dazo@...384...>	<20101115090236.GK258@...1296...>
	<20101115150551.9357.qmail@...1287...>
In-Reply-To: <20101115150551.9357.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Use stricter snprintf()	formatting
 in socks_username_password_auth()
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/11/10 16:05, Peter Stuge wrote:
> Gert Doering wrote:
>>> -  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", strlen(creds.username),
>>> -            creds.username, strlen(creds.password), creds.password);
>>> +  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", (int) strlen(creds.username) & 0xff,
>>> +            creds.username, (int) strlen(creds.password) & 0xff, creds.password);
>>
>> I tend to NAK this.
> 
> I agree. My ack is only for the other patches. (Sorry, I should have
> written that in the other mail.) A better solution for this should be
> simple as Gert outlined.

I didn't think about this when I wrote this patch, but I completely
agree!  I'll improve that part.  It's also silly to truncate the %c part
and not limit the %s as %.255s in this case.

Thanks for catching that, I'll send a new patch fixing this one!


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzhlJwACgkQDC186MBRfrpaPQCePSJrLAyNOysVGjG33NEGl46L
qG4An3npEuIjRry2EO+dfRnCO1BfiEuN
=dv5a
-----END PGP SIGNATURE-----

