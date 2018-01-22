MIME-Version: 1.0
In-Reply-To: <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
 <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 22 Jan 2018 10:06:25 -0500
Message-ID: <CAEsd45Te2r-akUZM0HEN+A=oavCOqAdLN-33d=na-__3=9JoSw@...278...>
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>, David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Hi,

On Mon, Jan 22, 2018 at 7:33 AM, David Sommerseth
<openvpn@...2080...> wrote:
> Let me rather twist this question around ... Do we want to support OpenSSL
> 0.9.8?  Are there any Linux distributions or other OSes out there in the wild
> which is still supported which are also based on openssl-0.9.8?
>
> Officially we dropped RHEL 5 support and moved to RHEL 6 as the oldest Linux
> distribution we support OpenVPN on.  RHEL 6 ships with an openssl-1.0.1e baseline.
>
> For the other platforms ... In Windows, we define what we want to use - as we
> need to embed OpenSSL in our own package.  I believe most of the current
> stable *BSDs and derivatives are on an OpenSSL 1.x base (or the LibreSSL fork)
> too (but I don't know that for a fact yet).  I expect Tunnelblick and macOS
> users to use a far newer OpenSSL library too.

Dropping 0.9.8 isn't a problem for Tunnelblick, which embeds OpenSSL 1.0.2.

However, 0.9.8 (patched by Apple, as I understand it) is included in
macOS up through Sierra. So people using command-line openVPN would
have problems unless they've replaced OpenSSL.

(Apple's latest system, "High Sierra" symlinks openvpn to LibreSSL,
which opens a different can of worms : )

Best regards,

Jon Bullard

