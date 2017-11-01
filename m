From: Simon Rozman <simon@...2293...>
Date: Wed, 1 Nov 2017 08:25:00 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE1085876852@...2294...>
References: <99D61A626FDA8A4B90A270669121BE108587171C@...2294...>
 <CAKuzo_her_KFBMA3Xt6zKGmHGLnc89qXkb=n_LnvxcSzsvdV+A@...278...>
 <99D61A626FDA8A4B90A270669121BE1085875356@...2294...>
 <CAKuzo_hpGEdV8fqTjRYWqPnb8b15JKmng_KrazQOPq6Kaq9qSQ@...278...>
In-Reply-To: <CAKuzo_hpGEdV8fqTjRYWqPnb8b15JKmng_KrazQOPq6Kaq9qSQ@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_0000_01D352F3.49A00230"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN Interactive Service Branding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>, "eduvpn@...321..." <eduvpn@...321...>

------=_NextPart_000_0000_01D352F3.49A00230
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

> Named instances sounds like is a good idea. As you pointed out, Microsoft
> itself uses command line parameters on service (like -i NAME for SQL server)
> so that looks kosher.
>
> There is a problem though: multiple instances also need multiple service
> names but the service name is hardcoded in the source. In our case even
> the dispatcher needs to know the service name(s) as we use
> SERVICE_WIN32_SHARE_PROCESS and share the process between
> the legacy service[*] and the interactive service.
>
> Looks like the service name also will have to be dynamically-generated
> from the instance name.

There is a simpler solution for that:

1. Change the order of services listed in `dispatchTable` so the interactive 
service is listed first.

2. All non-default instances could install as `SERVICE_WIN32_OWN_PROCESS`, 
thus SCM will launch them as a separate process picking only the first entry 
in the `dispatchTable` ignoring the service name and ignoring all non-first 
entries.

> If you want to support multiple installations of openvpn.exe/service,
> building with a different PACKAGE_NAME can't be avoided, can it?.
> Instead, if using the "official" executables is ok, why not just use
> oepnvpnserviceinteractive as is. Does eduVPN really need its own instance
> of the service?

No, actually eduVPN client is quite happy with the official interactive 
service as it is. Until we hit deployment issues with the 
openvpn-install-2.4.4-I601.exe installer described below.

- When OpenVPN is not already installed, we would like to install it using 
only the minimum feature selection. You see, OpenVPN GUI desktop shortcut and 
auto-start in system tray is not desirable, as it will confuse the end users 
how to start using eduVPN.
This can be accomplished using the command line parameters. So far so good.

- When an older version of OpenVPN is already installed, we would like to 
update it. Unfortunately, the installer does not detect currently installed 
features. It just copies the default feature set overwriting previous 
installation. Again, users get the OpenVPN GUI desktop shortcut and system 
tray icon. Even if they were not installed before.
We could use the command line parameters again to suggest a feature selection, 
but if the OpenVPN GUI was installed before, the update would not update it, 
leaving behind some sort of Frankenstein OpenVPN installation.
The installer is missing a command line parameter to tell it "if feature is 
present then update, else leave it absent".

- eduVPN will require latest up-to-date OpenVPN. Should any user require a 
specific older version of OpenVPN to connect to other service providers than 
eduVPN, this would be a problem.

Because of those issues, we would like to install local OpenVPN - and keep it 
up-to-date - using an MSI package. While openvpn.exe and its dependency DLLs 
can easily be managed as a local copy, the interactive service cannot - 
without interfering with original OpenVPN installation.

> That said, I like the idea of being able to run multiple (named) instances
> of the service each with its own service pipe.

I shall prepare, test and git-send-email a patch for it shortly. Thank you for 
your valued opinion.

Best regards,
Simon

------=_NextPart_000_0000_01D352F3.49A00230
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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

------=_NextPart_000_0000_01D352F3.49A00230--

