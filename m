MIME-Version: 1.0
In-Reply-To: <566C9E48.1040806@...1227...>
References: <CAEsd45Q9S_V137M5Db5jNT2ZFGju8XKMAUYqBeDYifjC5y=-MQ@...278...>
	<566C9E48.1040806@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 12 Dec 2015 17:37:55 -0500
Message-ID: <CAEsd45TE8ktqJtHw-+ZYHnS9m4VJR9A_kCaN-OQB8UaSeo4YAg@...278...>
Subject: Re: [Openvpn-devel] Options that are "safe" for users to modify?
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi.

On Sat, Dec 12, 2015 at 5:23 PM, Arne Schwabe <arne@...1227...> wrote:
> Might not really be related to this but have looked into the work that
> provides the certificates and keys via the managment console? We have
> even have a contrib program that gets certificates from the Mac OS X
> keychain and provides them to OpenVPN.

Thanks, but I think that should be a separate discussion. That would
work for some situations, but the keychain (actually, OS X has several
keychains) may not be accessible to OpenVPN; files are always
accessible, even before a user is logged in. And I don't think (I'm
doing this from memory, so I might be wrong) that the Keychain patch
allows **all** of the encryption info to be taken from the keychain: I
don't think it allows --secret, --ta, etc.

