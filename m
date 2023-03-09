From: Kristof Provost <kprovost@...2661...>
Date: Thu, 09 Mar 2023 09:36:57 +0100
Message-ID: <F9C9036B-0A31-4F9A-AD15-682141A1C069@...2661...>
In-Reply-To: <20230309005208.29704-1-a@...2181...>
References: <20230309005208.29704-1-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] dco: print version to log if available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

On 9 Mar 2023, at 1:52, Antonio Quartulli wrote:
> In order to provide better support in case of troubleshooting issues,
> it's important to know what exact DCO version is loaded on the user
> system.
>
> Therefore print the DCO version during bootup.
>
> For Windows and FreeBSD we currently implement a placeholder printing 'v0=
'.
> This should be improved with a follow-up patch.
>
FreeBSD is a bit special in this regard, because the DCO driver is part of =
the base operating system and not an add-on as in Linux and Windows.

Arguably the thing to do for FreeBSD is to log the OS version.

Kristof

