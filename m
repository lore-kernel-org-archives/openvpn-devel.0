References: <CAEsd45T17CTS6xAjLHvDTf80u18YpN73o1T5BmNtfAz8WBdXRQ@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <cc711041-84ec-0aa8-6a68-8ce9d04e63b9@...1435...>
Date: Wed, 7 Mar 2018 10:25:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAEsd45T17CTS6xAjLHvDTf80u18YpN73o1T5BmNtfAz8WBdXRQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] OpenSSL version(s) officially supported by
 OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 06-03-18 23:16, Jonathan K. Bullard wrote:
> Can someone clarify which versions of OpenSSL OpenVPN supports (that
> is, "works with when linked statically")?
> 
> From what I gather:
> 
>  * OpenVPN 2.3.18 supports OpenSSL 1.0.2n
>  * OpenVPN 2.4.5 supports OpenSSL 1.0.2n and 1.1.0g
>  * OpenVPN 2.5 will support OpenSSL 1.0.2n and 1.1.0g
> 
> Is that correct? (I assume OpenVPN 2.5 won't remove support for
> OpenSSL 1.0.2, which ends "Long Term Support" on 2019-12-31.)

Our configure.ac is "the truth" here.  It says:

OpenVPN 2.3 should work with OpenSSL 0.9.6+  (But, < 1.1)
OpenVPN 2.4 should work with OpenSSL 0.9.8+
OpenVPN master should work with OpenSSL 1.0.1+

Where master is of course still in flux, so we might increase the
minimum version at some point before the 2.5 release.

We still want to be compatible with those older openssl versions,
because distros with LTS such as RHEL and SLES do keep those older
versions up-to-date wrt security, and we'd like to build out-of-the-box
on those platform.

-Steffan

