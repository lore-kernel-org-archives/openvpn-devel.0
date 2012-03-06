MIME-Version: 1.0
In-Reply-To: <1331055760398534500@...1315...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<319492303.20120228213418@...449...>
	<1331052472905814500@...1315...>
	<CAOazyz0K7NONN9uFsqD5_uF_xmApF7BUmE8Wg_tarejrf5aVbw@...278...>
	<1331055760398534500@...1315...>
Date: Tue, 6 Mar 2012 20:26:17 +0200
Message-ID: <CAOazyz2q-W7M8v3ubU1G=Wa2XLwfzqP2HCtH6tsLXfgxpXQ3BA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN Management Interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Russell Morris <openvpn@...1315...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, openvpn-devel@lists.sourceforge.net

On Tue, Mar 6, 2012 at 7:42 PM, Russell Morris <openvpn@...1315...> wrote:
> Hi,
>
>
>
> That makes sense - thanks! I'm not a security expert by any means, so the
> thread lost me when it diverged into this area ... :-(.
>
>
>
> At the risk of asking a stupid question (but that is my specialty ... :-)) -
> is there a conclusion of how to deal with this?
>

This is not a stupid question at all.
In fact this is the correct question...
The wrong question is the privilege separation.

I rephrase the question: What is missing within openvpn to allow
proper UI management

Goal:
To be able to support OpenVPN in complete privilege separation from
the end-user, delegating user specific credentials.

OpenVPN core tasks:

1. Run without end-user credentials in OpenVPN configuration, meaning:
(Side note: there is no reason not to support both client and server
in this mode.)
a. For each session accept certificate via management interface.
b. Delegate signature operations to management interface. Although
this is already implemented but undocumented, it only support RSA,
needs to be extended to other algorithms such as EC.

2. Run without peer certificate validation in OpenVPN configuration, meaning:
a. Delegate peer-certificate validation to the management interface.
b. No need for CA, EKU, Subject, CRL etc in configuration.

3. Provide cross platform command-line tool to interact with the
management interface, this is the supported project tool.
a. Support passphrase.
b. Support file based certificate/key (PKCS#1, PKCS#12).
c. Support CryptoAPI.
d. Support PKCS#11.
e. Support peer certificate validation.
f. Support basic logging.
e. In future this simple CLI may transform to simple UI (Qt, GTK),
similar to wpa_supplicant's wpa_cli.

4. Depreciate the CryptoAPI and PKCS#11 from the OpenVPN sources, as
depreciated by (3), the discussion of read passphrase from file will
be gone too.

5. Support network configuration interface, so that user's supply
network configuration logic may be supported.
a. Can be supported using spawning process (I prefer as it is simpler).
b. Can be supported using plugin.

6. [low priority] Provide OpenVPN as a library, this will allow
components to load openvpn.so or openvpn.dll without creating a new
process (calling openvpn_main()).
a. New build system enables creating .so/.dll out of openvpn easily.
b. Create executable that uses the library (as for now).

This is non trivial, mainly due to the extensive use of global
variables in code, the nature of signal handling and the lazy
initialization. The lazy initialization is the most complex issue,
however it can be ignored as these configurations may be unsupported
in library mode.

7. [low priority] Remove the windows service code out of openvpn
project, as it should be implemented by UI project.

OpenVPN-UI Core Tasks:

1. Setup of privilege separation. discussed already. I can provide
detailed design.

2. Support management interface certificate/sign requests.
a. Support PKCS#1, PKCS#12.
b. Support CryptoAPI.
c. Support PKCS#11.

3. Support management interface peer certificate validation.
a. Support using PKCS#7.
b. Support using CryptoAPI.

4. Support user scripts on specific events, to allow user
customization, this is part of UI profile, has no relationship with
openvpn configuration files. These scripts will run at interactive
user context.
a. OnBeforeConnect.
b. OnConnect.
c. OnDisconnect.

5. Provide network configuration implementation for windows specific
privilege separation setup.

6. Provide installer, as it is not single file installation.

Alon

