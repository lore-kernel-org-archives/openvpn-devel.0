Message-ID: <41B07B80.6070102@...324...>
From: Stefan Engel <mail@...324...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] bugfix: SuSE handling in openvpn.spec
References: <41B0734E.3010105@...324...> <200412031618.44206@...187...>
In-Reply-To: <200412031618.44206@...187...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Dec  3 06:44:01 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: mr700@...184..., openvpn-users@lists.sourceforge.net

Doncho N. Gunchev wrote:
> On 2004 12 03 (Friday) 16:08, Stefan Engel wrote:
> 
>>Hi,
>>
>>there is a minor bug in openvpn.spec (v2.0_beta19). In the %files
>>section the init script is always taken from /etc/rc.d/init.d instead
>>of /etc/init.d in case of a SuSE distribution. This results in an
>>rpm build error on SuSE systems.
>>
>>The appended patch should fix this.
>>
>>Regards,
>>
>>Stefan
>>
> 
>     What gives "rpm --eval '%{_initrddir}'" on SuSE? In RH/FC it gives
> "/etc/rc.d/init.d", which I use in my .spec file:
> --- cut ---
> # to fix later: '--program-suffix 2' is optional, so use * here
> %{_initrddir}/*
> --- cut ---
>     instead of
> --- cut ---
> /etc/rc.d/init.d/%{name}
> --- cut ---
>     If accepted then
> --- cut ---
> %if "%{VENDOR}" == "SuSE"
> %__install -c -d -m 755 %{buildroot}/etc/init.d
> %__install -c -m 755 suse/%{name}.init %{buildroot}/etc/init.d/%{name}
> %else
> %__install -c -d -m 755 %{buildroot}/etc/rc.d/init.d
> %__install -c -m 755 sample-scripts/%{name}.init %{buildroot}/etc/rc.d/init.d/%{name}
> %endif
> --- cut ---
>     should be just one line :)
> --- cut ---
> %__install -c -d -m 755 %{buildroot}%{_initrddir}
> --- cut ---
> 

Using %{_initrddir} would be fine, if all rpm installation
would treat it correctly.

SuSE 9.2 correctly reports /etc/init.d, but SuSE 9.1 doesn't :-(

rpm --eval '%{_initrddir}' results, _initrddir is defined in
/usr/lib/rpm/i386-linux/macros:

SuSE 9.1: /etc/rc.d/init.d
%_initrddir             %{_sysconfdir}/rc.d/init.d

SuSE 9.2: /etc/init.d
%_initrddir             %{_sysconfdir}/init.d

SuSE 9.1 has no directory /etc/rc.d/init.d. Instead /etc/rc.d is
a link to /etc/init.d thus resulting in /etc/init.d/init.d. This
messes up the installation of the init-script.

The tests for SuSE in the spec file are correct in
sections %description, %install, %post and %preun, they are
only missing in the %files section.

