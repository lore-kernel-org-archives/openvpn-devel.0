Message-ID: <53638C45.6000405@...1901...>
Date: Fri, 02 May 2014 08:15:01 -0400
From: Timothe Litt <litt@...1901...>
MIME-Version: 1.0
References: <535ECBB0.2060709@...1901...> <5362D3E9.3090001@...1114...>
	<5362FA6D.904@...1901...> <20140502072322.GT16637@...1296...>
In-Reply-To: <20140502072322.GT16637@...1296...>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms050705050101000107000407"
Subject: Re: [Openvpn-devel] [Openvpn-users] [PATCH] Add support for
 specifying the syslog facility, as requested  in trac #188.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--------------ms050705050101000107000407
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

> (why is this being discussed on -users?  Taking it over to -devel)
Er, I did post it to -devel, and I don't see any discussion of it on=20
-users...I just double-checked the archives, and it's all in -devel...

>   --syslog-facility should be more clean, like
>
>   --sysloc-facility facility [progname]
--daemon and --syslog already control syslog's program name. Since we=20
would have to support the
existing usages, your suggestion to add that to --syslog-facility would=20
add complexity, not simplify things.
You really don't want that.

>   intermixing
> option argument "A" and "B" in the same string is not going to help anyon=
e.
Sorry that you don't like my accommodation for init scripts.  It helps=20
OpenVPN and its USERS.

> Init scripts can be adjusted.
The fact is that I'm not going to get all the distributions to change=20
their init scripts, and neither are you.  It's a major effort to do that=20
and get it coordinated across all the distributions.  No one  -- not me,=20
not you, and not the distro maintainers -- has time for that.

Asking our users to do it piecemeal - and maintain it or lobby their=20
distributions is not good engineering.  It's a problem that we can solve=20
on this end.

Even if one could get distro cycles to change their init scripts - why=20
would we waste them on something like this?  We'll
want them when we want something that can't be handled without their help...

> the last one really makes me want to throw up.
Yes, it's ugly.   And my stomach rumbles too.

If OpenVPN were engineered from scratch, --daemon would just daemonize,=20
--syslog would control the syslog program name and facility, and the two=20
could be used together.  And there wouldn't be silly ordering=20
constraints among the options.  But that's not the way the existing code=20
-- and customers' config and distros' init files -- work.

This is the real world, and sometimes we have to live with ugly. Even if=20
it makes us a little queasy.

> Using [] as part of an option string is a bad idea, because it is commonly
> used for optional arguments (as you saw in David's question), and

As for the choice of square brackets - the delimiter had to be something=20
easy to parse that is uncommon in program and file names.

The init file usage does not make it easy.  Facility can not be a=20
prefix, because the Debian usage I cite generates the --daemon argument
from the config file name -- adding a prefix.  It can't be a suffix=20
because of the way systemd-based distros auto-generate multiple instances.

So it has to be something that can be embedded anywhere in the string,=20=20
And that means delimiters on both ends.

I was aware that [ ] is used for 'optional' in syntax descriptions when=20
I picked them.  But I provided examples to clarify the point.
And the other choices were worse, as they have other meanings to shells=20
and filesystems.  At least [ ] is visually distinctive and
easy to remember.

It could be something else.  Do you have a better idea that doesn't add=20
complexity?

> It brings it's own config statement (--syslog-facility)
Actually, the first pass didn't - the facility was ONLY in the progname=20
argument.  See the patch in Trac, which was the minimal
change required to solve the problems.

However, the additional code is minimal, and for cases where it is=20
possible to avoid the ugly overloading of progname, it is a cleaner
way to specify facility.  I thought it worth the effort so as not to=20
force ugliness on users when it isn't required.

> someone else considered "a clever hack"

None of this was the result of random choices or "cleverness". I've been=20
in the software business long enough to have dealt
with more of that than most.  Try adding a major feature to a 30-year=20
old OS that's written in assembler...or to microcode.

I thought carefully about the issues, the requirement and how to meet it=20
in a way that minimizes the internal and external impacts.

I'm busy too - but I took the time to understand the problem and do a=20
proper job.  I checked multiple distributions, consulted
standards, localized the changes and did careful testing in the=20
environments that I have.  And tried to give back to the community.

I could have just compiled with -DLOG_OPENVPN=3DLOG_LOCAL5 and gone on=20
with my life... Or thrown an 'elegant' solution over
the wall and left customers to deal with the init file issues.

I didn't ignore it for 2 years, and I didn't let aesthetics get in the=20
way of the best solution that I could come up with.

> If we take this at all - and I have reservations, because the amount of
> code it brings in is quite significant
The scope is hardly large.  If you look at the actual code - the size of=20
the patch is dominated by documentation and the lookup table.
There are a couple of lines to parse the option, a subroutine to lookup=20
the names, and local block of code in open to handle the syntax.

Although the init-script compatibility is ugly and adds a few lines of=20
code, it meets the requirements with the least total impact to all=20
concerned.

> Feature-NAK
If you don't want the feature, why did you write in Trac #188:

> If someone does a patch, I think 2.4 is perfectly fine.
> For 2.3, I'm more sceptical - translating syslog strings to the=20
> syslog(3) facility values needs a translation table, lookup, some=20
> systems might not have all the facilities the rest has, so it's not a=20
> one-line change and needs cross-platform testing.
?

You clearly understood what was requested and the scope of the change,=20
aside from the init file issue that you didn't anticipate.  (And neither=20
did I, until I dug in to the problem.)

As soon as I tried to configure OpenVPN, I saw that it used syslog, and=20
the first thing I looked for was how to send output to a facility of my=20
choice.
I saw the request in Trac - and several times in the mailing=20
lists/forums.  I'm hardly the only person requesting the feature.

Given that the standard specifies the facility names, the local scope of=20
the code and the fact that to trigger any of the new code paths one has=20
to take positive action, I think this is reasonably safe for 2.3.

As I noted in the Trac ticket and in the previous notes, what I did was=20
carefully portable and standard-compliant.  It's not a one-line change;=20
it does
need testing, but it's not as bad as you thought.  Standards help.

I don't expect issues - but if there are any, they will happen the first=20
time it's compiled on some (probably obscure) platform that doesn't have=20
a required facility code.  It's unlikely, but possible.  It won't be=20
something subtle in the field -- like TLS1.2 :-(

But if you want to hold it for 2.4, it's your project.

And if you have a solution that is a lot prettier AND addresses the=20
init-file issues, I'm open to considering it.

At the moment, I'm still convinced that what I posted is the best=20
solution available.

Timothe Litt
ACM Distinguished Engineer
--------------------------
This communication may not represent the ACM or my employer's views,
if any, on the matters discussed.

On 02-May-14 03:23, Gert Doering wrote:
> Hi,
>
> (why is this being discussed on -users?  Taking it over to -devel)
>
> On Thu, May 01, 2014 at 09:52:45PM -0400, Timothe Litt wrote:
>> e.g. the following are valid:
>>            --daemon
>>                      Daemonize, use the default progname (from PACKAGE)
>> for syslog
>>
>>            --daemon my-vpn-daemon
>>                      Daemonize, use "my-vpn-daemon" for the syslog progn=
ame.
>>
>>            --daemon [local1]
>>                      Daemonize, use the default progname, use the local1
>> syslog facility (unless --syslog-facility already specified one)
>>
>>            --daemon my[local1]-vpn-daemon  --daemon
>> [local1]my-vpn-daemon --daemon my-vpn-daemon[local1]
>>                      Daemonize, use "my-vpn-daemon" for the syslog
>> progname.
>>                                           Use the local1 syslog facility
>> (unless --syslog-facility already specified one)
> Uh.  Feature-NAK - especially the last one really makes me want to throw =
up.
>
> Using [] as part of an option string is a bad idea, because it is commonly
> used for optional arguments (as you saw in David's question), and intermi=
xing
> option argument "A" and "B" in the same string is not going to help anyon=
e.
>
> If we take this at all - and I have reservations, because the amount of
> code it brings in is quite significant - it should not touch the --daemon
> command line.  It brings it's own config statement (--syslog-facility),
> so there really is no reason to mess up the syntax for --daemon.
>
> Also, --syslog-facility should be more clean, like
>
>   --sysloc-facility facility [progname]
>
> with "progname" actually being *optional*, not "marked by using rectangul=
ar
> brackets".
>
>
> [..]
>> As I explain above, this is to make it possible to specify a facility
>> name in cases where the system init script uses --daemon before the user
>> can put a --syslog-facility.  --syslog-facility must precede --daemon or
>> --syslog because the latter two immediately switch logging to syslog;
>> they are what consume the facility code when they call openlog().
>=20=20=20
> Init scripts can be adjusted.   Obscure code inside OpenVPN stays forever
> (guess why the developers have so little time?  right, maintaining stuff
> that someone else considered "a clever hack" 5 years ago).
>
> gert



--------------ms050705050101000107000407
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIPDzCC
BjQwggQcoAMCAQICASAwDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3
MTAyNDIxMDI1NVoXDTE3MTAyNDIxMDI1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMsohUWcASz7GfKrpTOM
KqANy9BV7V0igWdGxA8IU77L3aTxErQ+fcxtDYZ36Z6GH0YFn7fq5RADteP0AYzrCA+EQTfi
8q1+kA3m0nwtwXG94M5sIqsvs7lRP1aycBke/s5g9hJHryZ2acScnzczjBCAo7X1v5G3yw8M
DP2m2RCye0KfgZ4nODerZJVzhAlOD9YejvAXZqHksw56HzElVIoYSZ3q4+RJuPXXfIoyby+Y
2m1E+YzX5iCZXBx05gk6MKAW1vaw4/v2OOLy6FZH3XHHtOkzUreG//CsFnB9+uaYSlR65cdG
zTsmoIK8WH1ygoXhRBm98SD7Hf/r3FELNvUCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBSuVYNv7DHKufcd+q9rMfPIHeOsuzAfBgNV
HSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUH
MAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20v
c2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBADqp
Jw3I07QWke9plNBpxUxcffc7nUrIQpJHDci91DFG7fVhHRkMZ1J+BKg5UNUxIFJ2Z9B90Mic
c/NXcs7kPBRdn6XGO/vPc87Y6R+cWS9Nc9+fp3Enmsm94OxOwI9wn8qnr/6o3mD4noP9Jphw
UPTXwHovjavRnhUQHLfo/i2NG0XXgTHXS2Xm0kVUozXqpYpAdumMiB/vezj1QHQJDmUdPYMc
p+reg9901zkyT3fDW/ivJVv6pWtkh6Pw2ytZT7mvg7YhX3V50Nv860cV11mocUVcqBLv0gcT
+HBDYtbuvexNftwNQKD5193A7zN4vG7CTYkXxytSjKuXrpEatEiFPxWgb84nVj25SU5q/r1X
hwby6mLhkbaXslkVtwEWT3Van49rKjlK4XrUKYYWtnfzq6aSak5u0Vpxd1rY79tWhD3EdCvO
hNz/QplNa+VkIsrcp7+8ZhP1l1b2U6MaxIVteuVMD3X0vziIwr7jxYae9FZjbxlpUemqXjcC
0QaFfN7qI0JsQMALL7iGRBg7K0CoOBzECdD3fuZil5kU/LP9cr1BK31U0Uy651bFnAMMMkqh
AChIbn0ei72VnbpSsrrSdF0BAGYQ8vyHae5aCg+H75dVCV33K6FuxZrf09yTz+Vx/PkdRUYk
XmZz/OTfyJXsUOUXrym6KvI2rYpccSk5MIII0zCCB7ugAwIBAgICJtUwDQYJKoZIhvcNAQEF
BQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBD
bGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xMjA5MjUxODQyMTha
Fw0xNDA5MjcxOTIyNDJaMIGQMRkwFwYDVQQNExBPZ3RBNVhZZXZheGFkbGtKMQswCQYDVQQG
EwJVUzEWMBQGA1UECBMNTWFzc2FjaHVzZXR0czEVMBMGA1UEBxMMU291dGhib3JvdWdoMRUw
EwYDVQQDEwxUaW1vdGhlIExpdHQxIDAeBgkqhkiG9w0BCQEWEXRpbW90aGVAbGl0dHMubmV0
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA38JrSHJ7GVdQiTppuafIBrhphuLL
HAmpeAFNvUBuUUh4X8Nx4Ag03hrC/B7OWYpUJI1HgWCK/eMtKEWF7UMwFhkMeqWSdrZyb4uk
EqTf46SyyAghF6BGuuVTiptED63FwzQY2PTXCmAJviuRXoJMzlhAwzUFpsWTFhswigFLrMCn
kJ9nndqnxQmMFpD7pjJ6kFkxKz/5k1CEzAfSerWHkIOBuXFyYpDDgDFXN1+qF25HsVVw+4xT
1/tNvCEVQ9WAleUznLvWgT5sV8tTewsUiYOgSqyoHiuJCOc9YJF2pUHGZVV+WzS8YIb95ax5
5yoS+C3D3FFzl6CbcI3nc6csqkP4bNBqm96Z/WdfTV4ouoycI4N9AJ86l6/Ygjz3/juFI9ni
as8nE051hksnyCon87fyP3/NezZ9NcUYVUnki1cVhfh2cN+s79fGWbUJePjT0fmso0FVcSRp
ddLyeZladbifFG+TiQO9BFt97e16OwyFpXRIzZWnfEiG2ss51Vpv9au8RrLgBD07aKE3mzZp
xZzoZ8c/jgb1YcUyAyaVmdOk4A3eGe7c8Loa+eYIRwkbjoE6H/PKcoRNIqnYQ44zvOOONRDI
S3vBpzofVK5Ndx0NVDIvsbWEPb9ntR32taUUZ334SPN447UO3sjvItFg1oOuC1i6kL6l1vRM
GNouPvECAwEAAaOCBDcwggQzMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUJZNwH8x9MtxbZmI9AK6Jj+IELcowHwYD
VR0jBBgwFoAUrlWDb+wxyrn3HfqvazHzyB3jrLswgaYGA1UdEQSBnjCBm4ERdGltb3RoZUBs
aXR0cy5uZXSBEXRpbW90aGVAbGl0dHMubmV0gQxsaXR0QGFjbS5vcmeBDWxpdHRAaWVlZS5v
cmeBFGhvc3RtYXN0ZXJAbGl0dHMubmV0gRdsaXR0c25ldGFkbWluQGxpdHRzLm5ldIETd2lr
aWFkbWluQGxpdHRzLm5ldIESc2VjdXJpdHlAbGl0dHMubmV0MIICIQYDVR0gBIICGDCCAhQw
ggIQBgsrBgEEAYG1NwECAjCCAf8wLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2lu
dGVybWVkaWF0ZS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3Jk
aW5nIHRvIHRoZSBDbGFzcyAyIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFy
dENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3Nl
IGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGcBggr
BgEFBQcCAjCBjzAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRM
aWFiaWxpdHkgYW5kIHdhcnJhbnRpZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdh
bCBhbmQgTGltaXRhdGlvbnMiIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQv
MC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUyLWNybC5jcmwwgY4GCCsG
AQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIv
Y2xhc3MyL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20v
Y2VydHMvc3ViLmNsYXNzMi5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEAXJ5dj2hKDwAh3aPsYWSJdC6PE7O2
u4pZz4H1mucRf3ZLoLjrAMhtINAqrWkvfiOTWQruNpQAXL+Gb6pk5sDoSXwISbPraVMb4uCS
g++F/XTCvqfsCitXd6Jhl5dyV0pi2MwmHyrBsjsER1EwA+39av+cfoL0gKuJy5y92wRt0It8
Eu77N5HaMlDlxEXXTQWP5Q2g7IZy+/ZeeG8FjrUM/bmwyvdb3mBreKgL2mZHnG+mf09IDACG
9ogoV2xJNQ0lRHxH5NJ/XGSztQACboxl3wK/t86Vhh6i1JeaLMcJ5oaemxdATK0NZVk/hIK0
hXGzTMVw1xoP/9LSYyoRD6yypzGCBNowggTWAgEBMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQG
A1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNh
dGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAibVMAkGBSsOAwIaBQCgggIbMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0MDUwMjEyMTUwMVowIwYJKoZIhvcNAQkEMRYEFMxF
2veD+7Ya7ZgngKu+w54KZpT5MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgaQGCSsGAQQBgjcQBDGBljCBkzCBjDELMAkGA1UEBhMC
SUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENl
cnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDIgUHJpbWFyeSBJ
bnRlcm1lZGlhdGUgQ2xpZW50IENBAgIm1TCBpgYLKoZIhvcNAQkQAgsxgZaggZMwgYwxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFBy
aW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQICJtUwDQYJKoZIhvcNAQEBBQAEggIAf6in
JSfTY2VR85L5PATr14SIdt637hEtTAVYbUf48/EtZoOMFp0cEy3rnDHW+YO3Xo+kz1ghoA2H
2D+6/8Bl5nvsCfCpItPJBjWOp04ZpYUWpX04S+AzD1hs0u0c2r8iTdABXImxfqioAqgitvNC
p7WwxTIbqH1OPSLx4ewe7SQYhmzhWj7MdDo8vT3s7fBQbliUOl4GcwG7y8QPla0+ErMtPzMj
Wtkl3fFRmVS41n4R7bq4eXGtg1ZFVdzz31xftHAmjAKophn1tdxm6xRD47qz/fLj9dTS9RKa
TiuzzEQ2eA6wmALGdzOYHcSHwzmgJqsM2EZCb3+pAfpST7nszYE84UfgIsHAEyft+lj11cVI
PBQGVaZOFNjV1oMk9weuuraTa9J4xqIo1eEner5mkdUHT3+USXphSk5Ey8Dq7G3ioqzpbAFK
pJ6jFaeMraRRLI8qex3VE+h62aQggwDftrizrvTNAgnBi46KaMUrKh/8dX5McBDXnRFG86ON
1kNz7VPDJh+eDlMFj6l5GGkMa6UZC9MC+AZs/U8AKWB7KKuzkYOnxoEoourcbKUXANI6Fjc/
GlFt7bX37jNLXyX0rNYGYKC+8RIWMwp1novYAjXiwGQR678JDRNyNNGeVQya1+4kdjMQAekX
N8MlTk3iGZQn5472BlTxxlvSQmALg5MAAAAAAAA=
--------------ms050705050101000107000407--

