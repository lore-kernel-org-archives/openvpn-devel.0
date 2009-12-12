Message-ID: <4B240A82.6030502@...1114...>
Date: Sat, 12 Dec 2009 22:26:26 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1260552743.31755.0@...1207...> <4B22D2C8.5020703@...41...>
In-Reply-To: <4B22D2C8.5020703@...41...>
Subject: Re: [Openvpn-devel] OpenVPN project organization [WAS: Introducing
 OpenVPN Community Manager]
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
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/12/09 00:16, James Yonan wrote:
>> 
>> However, it _could_ be a requirement that all patches be submitted
>> with documentation.  If not, I can't see how you'd want to
>> include any functional changes without also having documentation
>> so somebody else would have to be gotten to document the patch.
>> This is obviously up to whomever reviews the patches.
>> 

I would strongly recommend good commit comments from the persons
providing patches.  This should contain a description of what is changed
and why.  If the change is complex, it should also describe how the
patch fixes the issue.  On smaller or simpler patcher, this might
usually be enough.  But on bigger changes, especially with more code
being added to OpenVPN, the code itself should also have good and
descriptive comments as well.  What is obvious for the developer writing
the patch in that moment, might not be so obvious for a different
developer a few years later on.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkskCncACgkQDC186MBRfrr13wCghI5YuFCy3ihi7akjxm/1k4wi
QzgAoJgRMSizsfvhw76TKBCI6PI6/M/q
=DOcZ
-----END PGP SIGNATURE-----

