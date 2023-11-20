Message-ID: <c4b46bc4-b953-e2a3-91c0-1a015773306f@...1227...>
Date: Mon, 20 Nov 2023 09:55:34 +0100
MIME-Version: 1.0
References: <69296454-829c-4f6b-a528-a741e8ef96d2@...2702...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <69296454-829c-4f6b-a528-a741e8ef96d2@...2702...>
Subject: Re: [Openvpn-devel] OpenVPN3 thread safety
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Savely Krasovsky <savely@...2753...>, openvpn-devel@lists.sourceforge.net


Am 12.11.2023 um 14:16 schrieb Savely Krasovsky:
> Hello!
>
> I am trying to use OpenVPN3 with Golang SWIG binding. It works pretty nice, but I have random segmentation faults without obvious reason. My current guess is that Golang calls OpenVPN3 from various threads and library is not ready for that sometime. Am I right? Documentation doesn't say a lot about threading.
>
> If this is a case, I have two possible solutions:
>   1. Use OPENVPN_ENABLE_BIGMUTEX build flag (I am not sure I need that).
>   2. Move all calls to OpenVPN3 into single goroutine and use runtime.LockOSThread().
>
> Could you please clarify, should I get segfaults in that case or not and the problems is unrelated.


Yes. The client is singlethreaded and expects to be called only from a 
single thread. You can have multiple clients in multiple threads but all 
our own software uses just a single thread for the client itself.


Arne


