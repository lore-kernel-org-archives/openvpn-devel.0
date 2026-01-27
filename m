MIME-Version: 1.0
References: <0054b4ff-731a-4a23-b8e6-2cd312ae5557@...2722...>
 <CAEsd45TAbZGL2nifwf=Ex_1K1w=spTcjgca0Aqb760=s94EPLA@...278...>
 <aXk3ClJBS9_vsHpo@...1296...>
In-Reply-To: <aXk3ClJBS9_vsHpo@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Tue, 27 Jan 2026 17:29:57 -0500
Message-ID: <CAEsd45RsEXfh64Qr-Kxm9mER3GRT5bD-F3=rJtZymwJGaHZZ4g@...278...>
Subject: Re: [Openvpn-devel] IRC community meeting summary
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Gert Doering <gert@...1296...>

Hi!

On Tue, Jan 27, 2026 at 5:07=E2=80=AFPM Gert Doering <gert@...1296...> wrot=
e:
>
> The original plan was to avoid adding more patches to 2.7_rc5, and
> release it "as 2.7.0" tomorrow(-ish).  Unfortunately people kept finding
> bugs...
>
> My current plan is 2.7_rc6 tomorrow or thursday(-ish), and 2.7.0 in
> two weeks, with hopefully only very little changes between rc6 and .0.
>
> As for 2.6.18, we could do that "in between", like, Wednesday next week
> - there's quite a bit of goodness in that branch, so it makes sense to
> use the opportunity.

Thanks! I'll go ahead and do a Tunnelblick beta release in the next day or =
two.

> I haven't looked at the OpenSSL release - is this
> something urgent?  Or just using the opportunity?

Just using the opportunity. I'm not always clear on what OpenSSL
vulnerabilities would impact OpenVPN, but nothing looked urgent in my
quick look at the vulnerabilities list [1]. I haven't even seen an
email about the release or the vulnerabilities, but the 3.5.5 release
is available on GitHub [2] and it seems to work in my testing so far.

[1] https://openssl-library.org/news/vulnerabilities/
[2] https://github.com/openssl/openssl/releases/tag/openssl-3.5.5

