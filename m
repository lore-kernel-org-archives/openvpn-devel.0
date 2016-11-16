References: <1479163508-19435-1-git-send-email-davids@...515...>
	<c4d87247-460c-0860-5748-a62f0304653a@...1435...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <c2d24d70-8987-ee72-67de-26ca2bc64d66@...1435...>
Date: Wed, 16 Nov 2016 12:04:23 +0100
MIME-Version: 1.0
In-Reply-To: <c4d87247-460c-0860-5748-a62f0304653a@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] file checks: Merge
 warn_if_group_others_accessible() into check_file_access()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 16-11-16 11:44, Steffan Karger wrote:
> I was also wondering, have you tested that this work as expected on
> Windows?  Since Windows has a quite different permission system.  Or
> will is simply never warn, like before?  That would be fine for this patc=
h.

According to https://msdn.microsoft.com/en-us/library/3kyc8381.aspx, the
S_IRWXG|S_IRWXO flags we're checking for will never be set on Windows,
so that's fine.

-Steffan

