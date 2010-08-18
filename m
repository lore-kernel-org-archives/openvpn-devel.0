Message-ID: <4C6BD8BE.3000608@...1114...>
Date: Wed, 18 Aug 2010 14:57:34 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1282134451-21285-1-git-send-email-dazo@...384...>
	<4C6BD3E9.6060909@...68...>
In-Reply-To: <4C6BD3E9.6060909@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Test framework improvment - Do not FAIL
 if	t_client.rc is missing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/08/10 14:36, Matthias Andree wrote:
> Am 18.08.2010 14:27, schrieb David Sommerseth:
>> This is to avoid 'make check' fail if this extra test case is not
>> configured.  The patch gives a PASS, but will notify the user that
>> this test was skipped.
> 
> The other question is how t_client.rc can go missing...

The default is to only ship a t_client.rc.sample file which really needs
to be configured before running this test.  Anyhow, as this is a new and
additional test to what 'make check' already does, we're taking the slow
pace, making sure this framework works before taking it one step further.


Kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxr2LsACgkQDC186MBRfrouxgCfYX7rucl2aUrngTXJ/MBgjFaB
ge8An05NuCLvZ3Uqx7MumNxLTRi7v8hE
=AxFr
-----END PGP SIGNATURE-----

