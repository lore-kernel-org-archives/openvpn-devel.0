References: <1498475606-8337-1-git-send-email-arne@...1227...>
	<99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <73f851af-608e-7a15-1021-82cb0b05dada@...1227...>
Date: Mon, 26 Jun 2017 14:12:25 +0200
MIME-Version: 1.0
In-Reply-To: <99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before
 loading certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 26.06.17 um 13:51 schrieb David Sommerseth:
> On 26/06/17 13:13, Arne Schwabe wrote:
>> OpenSSL 1.1 does not allow MD5 signed certificates by default anymore. This can be enabled again by settings tls-cipher "DEFAULT:@SECLEVEL=0" but only if the cipher list is set before loading the certificates. This patch changes the order of loading.
> 
> I'm not fully convinced of the argumentation for this feature - unless
> something have changed in OpenSSL 1.1.  I believe the same can be
> achieved by setting an environment variable before starting OpenVPN.
> 
>   $ OPENSSL_ENABLE_MD5_VERIFY=1 /usr/sbin/openvpn ....
> 
> I know several Fedora users have deployed this, even when systemd is
> involved.  This is needed on systems with OpenSSL 1.0 as well when they
> connect to a server having an MD5 based certificate or signed by a CA
> with an MD5 based certificate.
> 
> So unless OpenSSL 1.1 have changed this behaviour from OpenSSL 1.0, I'm
> not really convinced we need this.
> 
> 

See this also a bugfix. Since tls-cipher options affect certificate
loading, it is good to set it before certificate loading. E.g. you might
want to use @SECLEVEL=5 to only allow loading of SHA256 based certificates.

Also I think your option is Fedora specific as I could not find anything
in the source code in my OSSL copy and the message also mentions it
being Fedora specific:

** WARNING ** [Fedora modification] MD5 certificate hash re-enabled via
OPENSSL_ENABLE_MD5_VERIFY environment variable.


Arne

