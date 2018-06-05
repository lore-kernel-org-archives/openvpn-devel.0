References: <20180417165000.3872-1-Jason@...2390...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <bda481bb-6f6a-e13c-1d99-608f47e94e65@...2318...>
Date: Tue, 5 Jun 2018 22:59:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180417165000.3872-1-Jason@...2390...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Jason A. Donenfeld" <Jason@...2390...>, openvpn-devel@lists.sourceforge.net

On 04/17/2018 06:50 PM, Jason A. Donenfeld wrote:
>    * Allow specifying 'none' to the --ca parameter, to specify that
>      certificates should not be checked against a CA. Note that 'none'
>      is already used in other similar options as a special placeholder.
> 
>    * When '--ca none' is in use, --verify-hash checks all depths instead
>      of just level 1.
> 
> With these very simple changes, fingerprint authentication is easily achieved
> via the --tls-verify script on the server and via --verify-hash on the client.

This is a great idea! I already played around with it, and it works as
advertised :)

I recently thought about how to integrate this properly. The thing that
is still missing is using fingerprints as CNs. The --status command, and
management interface (--management) use CNs to identify clients when
certificates are used. This would then also need to be modified to use
'fingerprints' as identifiers so you would see the fingerprints when you
use --status and can use fingerprints when you do "kill" through the
management interface.

An option similar to --username-as-common-name, e.g.
--fingerprint-as-common-name could be introduced to accomplish this in
an easy way, although it is a bit "hacky".

Cheers,
François

