MIME-Version: 1.0
References: <222922b3-377a-3eab-1edc-7dc692471196@...2181...>
 <20220113215226.161-1-lstipakov@...277...>
 <d7c4579c-1a29-855b-624b-04066d52bb53@...2181...>
In-Reply-To: <d7c4579c-1a29-855b-624b-04066d52bb53@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 15 Jan 2022 14:00:46 -0500
Message-ID: <CAKuzo_gy_xHzy8Tscb8xJ7QKN5+OZZksG7o_0eYkao8FDDJ5WA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] tun: remove tun_finalize()
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lstipakov@...277...>

Hi,

On Sat, Jan 15, 2022 at 3:25 AM Antonio Quartulli <a@...2181...> wrote:
>
> Hi Selva,
>
> we were hoping to hear your opinion on this :-)
>
> We spent quite some time figuring out if we have to use both the non-WSA
> and the WSA variant of the API in our code, and it seems we have to.
>
> (not because using one variant only would not work, but rather because
> the spec demands using WSA with sockets and non-WSA with file handles)
>
> What's your take?
> Assuming you agree with us, does this patch look reasonable to you?

As far as I know, the reason for identical sounding functions with and
without WSA prefix is mostly historical. e.g.,  WSAGet/SetLastError()
and Get/SetLastError() are likely identical functions internally.
Tests show error code set by one is overwritten by the other etc.

That said, it's better to stick to the docs and use WSA functions with
sockets as opposed to file handles. In any case we have to distinguish
the two for GetOverlappedResult() as the WSA version also returns an
additional flag.

The way I see it, the patch is eliminating a chunk of nearly identical
code, and use of an ambivalent struct holding socket/file-handle and a
few macros is a small price to pay for that.

So, looks reasonable to me assuming any effect on performance is negligible.

A minor thing:
+
+#define SocketHandleSetLastError(sh, ...) (sh.is_handle ? \
+    SetLastError(__VA_ARGS__) : WSASetLastError(__VA_ARGS__))

Why __VA_ARGS__?
As SetLastError() takes a single argument, wouldn't

#define SocketHandleSetLastError(sh, err) (sh.is_handle ?
SetLastError(err) : WSASetLastError(err))

be better?

Selva

