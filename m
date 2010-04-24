Message-ID: <4BD2C1F8.9080306@...1114...>
Date: Sat, 24 Apr 2010 12:03:36 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272082144.16099.2@...1207...>
In-Reply-To: <1272082144.16099.2@...1207...>
Subject: Re: [Openvpn-devel] openvpn error messages on the administrative
 interface?
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/04/10 06:09, Karl O. Pinc wrote:
> On 04/23/2010 01:36:56 AM, Huzaifa Sidhpurwala wrote:
>> Hi All,
>> I have been patching NetworkManager-openvpn for some time now, trying
>> to
>> enable some functionality, which a lot of
>> people use.
>> The main problem we have been facing for some time now, is that
>> openvpn
>> throws error messages only in the logs,
>> due to which any form of graphical output for us, is only possible by
>> screen
>> scraping these logs, which is a real pain.
>>
>> I am thinking if we can make openvpn show these messages on the
>> administrative interface or something similar so that programatically
>> it
>> would become easier to parse them and show them graphical to the 
>> user.
> 
> Wny not configure your syslog program to pipe log messages straight
> into some program you write that delivers the messages where ever you
> want them?   Or use UDP, TCP or RELP instead of a pipe.
> 
> Or is the problem that MS Windows does not support --syslog?
> 

NetworkManager-openvpn is most known on the Linux platform, and might
maybe be used on other platforms like Solaris or *BSD.

Piping syslog messages to a process will also be non-trivial, as you
need to support a broad setup of distributions, which might use
different syslog implementations with different config syntaxes.

Using the management interface would be the proper solution, IMHO.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvSwfgACgkQDC186MBRfrpOIwCfWv3ByQQ5wH7DFs2jqg+jxwfs
bzUAn3YGpYOb1r2MtcreuUqKd5+hZqZH
=YRd6
-----END PGP SIGNATURE-----

