package javaee;

import java.util.ArrayList;
import java.util.Iterator;

public class ShoppingCart {
	/**
	 * ��������CartItem�������������
	 */
	private ArrayList<CartItem> cart;

	public ShoppingCart() {
		cart = new ArrayList<CartItem>();
	}

	/**
	 * ���ذ��������Ѿ��������Ʒ��Ϣ����������
	 * @return ��ǰ��items��������
	 */
	public ArrayList<CartItem> getCart() {
		return cart;
	}

	/**
	 * ���һ����Ʒ�����ﳵ�У����������Ʒ�ڹ��ﳵ���Ѿ����ڣ�
	 * �Ǿ��޸����е���Ʒ��������
	 * ��֮������һ���µ�CartItem������ӵ�items�����С�
	 * @param item �����Ĵ���������Ʒ�Ķ���
	 */
	public void addCartItem(CartItem item) {
		CartItem oldItem = null;
		if (item != null) {
			for (int i = 0; i < cart.size(); i++) {
				oldItem = cart.get(i);
				if (oldItem.getId()==item.getId()) {
					oldItem.setQuantity(oldItem.getQuantity() + item.getQuantity());
					return;
				}
			}
			cart.add(item);
		}
	}

	/**
	 * �ӹ��ﳵ�У�ɾ����Ʒ��
	 * @param id ��ɾ����Ʒ����Ʒ���
	 * @return ɾ���ɹ�������true����֮����false
	 */
	public boolean removeCartItem(int id) {
		CartItem item = null;
		for (int i = 0; i < cart.size(); i++) {
			item = cart.get(i);
			if (item.getId()==id) {
				cart.remove(i);
				return true;
			}
		}
		return false;
	}

	/**
	 * ��������������Ʒ���ܼۡ�
	 * @return ��Ʒ���ܼ�
	 */
	public double getTotal() {
		Iterator<CartItem> it = cart.iterator();
		double sum = 0.0;
		CartItem item = null;
		while (it.hasNext()) {
			item = it.next();
			sum = sum + item.getSum();
		}
		return sum;
	}
}